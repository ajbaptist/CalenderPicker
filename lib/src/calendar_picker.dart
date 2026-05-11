import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'controllers/calendar_controller.dart';
import 'models/calendar_config.dart';
import 'models/calendar_selection.dart';
import 'models/calendar_style.dart';
import 'theme/calendar_theme.dart';
import 'utils/date_utils.dart';
import 'widgets/calendar_date_item.dart';

/// A modern, customizable Flutter calendar picker with horizontal timeline.
///
/// Supports single date selection, multi-date selection, and date range selection
/// with extensive customization options.
class CalendarPicker extends StatefulWidget {
  /// The selection mode for the calendar.
  final CalendarSelectionMode selectionMode;

  /// The initial selection state.
  final CalendarSelection? initialSelection;

  /// Configuration options for the calendar.
  final CalendarConfig config;

  /// Style configuration for the calendar.
  final CalendarStyle? style;

  /// Optional controller for managing calendar state.
  final CalendarController? controller;

  /// Callback when a date is selected.
  final ValueChanged<DateTime>? onDateSelected;

  /// Callback when multiple dates are selected.
  final ValueChanged<List<DateTime>>? onDatesSelected;

  /// Callback when a date range is selected.
  final void Function(DateTime? start, DateTime? end)? onRangeSelected;

  /// Callback when the month changes.
  final ValueChanged<DateTime>? onMonthChanged;

  /// Callback when a disabled date is tapped.
  final ValueChanged<DateTime>? onDisabledDateTap;

  const CalendarPicker({
    super.key,
    this.selectionMode = CalendarSelectionMode.single,
    this.initialSelection,
    CalendarConfig? config,
    this.style,
    this.controller,
    this.onDateSelected,
    this.onDatesSelected,
    this.onRangeSelected,
    this.onMonthChanged,
    this.onDisabledDateTap,
  }) : config = config ?? const CalendarConfig();

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  late CalendarController _controller;
  late ScrollController _scrollController;
  DateTime? _currentMonth;
  StreamSubscription<CalendarSelection>? _selectionSubscription;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? CalendarController(config: widget.config);
    if (widget.initialSelection != null) {
      _controller.selection = widget.initialSelection!;
    }
    _scrollController = ScrollController();
    _selectionSubscription =
        _controller.selectionStream.listen(_onSelectionChanged);
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    await initializeDateFormatting(widget.config.locale, null);
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(CalendarPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _selectionSubscription?.cancel();
      _controller =
          widget.controller ?? CalendarController(config: widget.config);
      if (widget.initialSelection != null) {
        _controller.selection = widget.initialSelection!;
      }
      _selectionSubscription =
          _controller.selectionStream.listen(_onSelectionChanged);
    }
    if (widget.config.locale != oldWidget.config.locale) {
      _initializeLocale();
    }
  }

  @override
  void dispose() {
    _selectionSubscription?.cancel();
    _scrollController.dispose();
    // Only dispose controller if we created it
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onSelectionChanged(CalendarSelection selection) {
    switch (widget.selectionMode) {
      case CalendarSelectionMode.single:
        final date = selection.singleDate;
        if (date != null) {
          widget.onDateSelected?.call(date);
        }
        break;
      case CalendarSelectionMode.multiple:
        widget.onDatesSelected?.call(selection.selectedDates);
        break;
      case CalendarSelectionMode.range:
        widget.onRangeSelected?.call(selection.rangeStart, selection.rangeEnd);
        break;
    }
  }

  void _onDateTap(DateTime date) {
    if (widget.config.isDateDisabled(date)) {
      widget.onDisabledDateTap?.call(date);
      return;
    }

    switch (widget.selectionMode) {
      case CalendarSelectionMode.single:
        _controller.selectDate(date);
        break;
      case CalendarSelectionMode.multiple:
        _controller.toggleDate(date);
        break;
      case CalendarSelectionMode.range:
        final currentSelection = _controller.selection;
        if (currentSelection.rangeStart == null) {
          _controller.selectRange(date, null);
        } else if (currentSelection.rangeEnd == null) {
          final start = currentSelection.rangeStart!;
          final end = date;
          // Ensure start is before end
          final rangeStart = start.isBefore(end) ? start : end;
          final rangeEnd = start.isBefore(end) ? end : start;
          _controller.selectRange(rangeStart, rangeEnd);
        } else {
          // Reset and start new range
          _controller.selectRange(date, null);
        }
        break;
    }
  }

  void _onMonthChange(DateTime month) {
    if (_currentMonth == null ||
        !CalendarDateUtils.isSameDay(_currentMonth!, month)) {
      _currentMonth = month;
      _controller.notifyMonthChanged(month);
      widget.onMonthChanged?.call(month);
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const CalendarStyle();

    return CalendarTheme(
      style: effectiveStyle,
      child: Container(
        height: widget.config.height,
        color: effectiveStyle.backgroundColor,
        child: ScrollConfiguration(
          behavior: _CalendarScrollBehavior(),
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.config.enableInfiniteScroll
                ? null // Infinite scroll
                : widget.config.daysCount ?? 365,
            itemBuilder: (context, index) {
              final date =
                  widget.config.effectiveStartDate.add(Duration(days: index));

              // Check if month changed
              final monthStart = CalendarDateUtils.getStartOfMonth(date);
              if (_currentMonth == null ||
                  !CalendarDateUtils.isSameDay(_currentMonth!, monthStart)) {
                _onMonthChange(monthStart);
              }

              return CalendarDateItem(
                date: date,
                config: widget.config,
                selection: _controller.selection,
                onTap: _onDateTap,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CalendarScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}
