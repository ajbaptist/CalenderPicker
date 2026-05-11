import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/calendar_config.dart';
import '../models/calendar_selection.dart';
import '../theme/calendar_theme.dart';
import '../utils/date_utils.dart';

/// A single date item in the calendar picker.
class CalendarDateItem extends StatelessWidget {
  /// The date to display.
  final DateTime date;

  /// The calendar configuration.
  final CalendarConfig config;

  /// The current selection state.
  final CalendarSelection selection;

  /// Callback when the date is tapped.
  final ValueChanged<DateTime> onTap;

  const CalendarDateItem({
    super.key,
    required this.date,
    required this.config,
    required this.selection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = CalendarTheme.styleOf(context);
    final isDisabled = config.isDateDisabled(date);
    final isSelected = selection.contains(date);
    final isToday = config.highlightToday && CalendarDateUtils.isToday(date);
    final isWeekend =
        config.highlightWeekends && CalendarDateUtils.isWeekend(date);
    final isActive = config.isDateActive(date);
    final isInRange = selection.isInRange(date);
    final isRangeStart = selection.isRangeStart(date);
    final isRangeEnd = selection.isRangeEnd(date);

    // Determine the appropriate text styles
    TextStyle dayTextStyle;
    TextStyle dateTextStyle;
    TextStyle monthTextStyle;

    if (isDisabled) {
      dayTextStyle = style.disabledDayTextStyle;
      dateTextStyle = style.disabledDateTextStyle;
      monthTextStyle = style.disabledMonthTextStyle;
    } else if (isSelected) {
      dayTextStyle = style.selectedDayTextStyle;
      dateTextStyle = style.selectedDateTextStyle;
      monthTextStyle = style.selectedMonthTextStyle;
    } else if (isToday) {
      dayTextStyle = style.todayDayTextStyle;
      dateTextStyle = style.todayDateTextStyle;
      monthTextStyle = style.todayMonthTextStyle;
    } else if (isWeekend) {
      dayTextStyle = style.weekendDayTextStyle;
      dateTextStyle = style.weekendDateTextStyle;
      monthTextStyle = style.weekendMonthTextStyle;
    } else {
      dayTextStyle = style.dayTextStyle;
      dateTextStyle = style.dateTextStyle;
      monthTextStyle = style.monthTextStyle;
    }

    // Determine the appropriate decoration
    BoxDecoration decoration;
    if (isDisabled) {
      decoration = style.disabledDecoration;
    } else if (isRangeStart) {
      decoration = style.rangeStartDecoration;
    } else if (isRangeEnd) {
      decoration = style.rangeEndDecoration;
    } else if (isInRange) {
      decoration = style.rangeDecoration;
    } else if (isSelected) {
      decoration = style.selectedDecoration;
    } else if (isToday) {
      decoration = style.todayDecoration;
    } else if (isWeekend) {
      decoration = style.weekendDecoration;
    } else {
      decoration = style.defaultDecoration;
    }

    // Add active indicator if needed
    if (isActive && !isSelected && !isDisabled) {
      decoration = decoration.copyWith(
        border: Border.all(
          color: style.activeColor,
          width: 2,
        ),
      );
    }

    return Semantics(
      label: _buildAccessibilityLabel(),
      selected: isSelected,
      enabled: !isDisabled,
      button: true,
      child: InkWell(
        onTap: isDisabled ? null : () => onTap(date),
        borderRadius: BorderRadius.circular(style.itemBorderRadius),
        child: Container(
          width: config.itemWidth,
          height: config.height,
          margin: EdgeInsets.symmetric(horizontal: config.itemSpacing / 2),
          decoration: decoration,
          child: Padding(
            padding: style.itemPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (config.showMonthHeaders && date.day == 1)
                  SizedBox(
                    height: style.headerHeight,
                    child: Center(
                      child: Text(
                        CalendarDateUtils.getMonthName(date, config.locale),
                        style: monthTextStyle,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                const SizedBox(height: 4),
                Flexible(
                  fit: FlexFit.loose,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      CalendarDateUtils.getWeekdayName(date, config.locale),
                      style: dayTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Flexible(
                  fit: FlexFit.loose,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      date.day.toString(),
                      style: dateTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _buildAccessibilityLabel() {
    final buffer = StringBuffer();

    buffer.write(CalendarDateUtils.getWeekdayName(date, config.locale));
    buffer.write(', ');
    buffer.write(DateFormat.yMMMMd(config.locale).format(date));

    if (config.isDateDisabled(date)) {
      buffer.write(', disabled');
    }

    if (selection.contains(date)) {
      buffer.write(', selected');
    }

    if (CalendarDateUtils.isToday(date)) {
      buffer.write(', today');
    }

    if (CalendarDateUtils.isWeekend(date)) {
      buffer.write(', weekend');
    }

    return buffer.toString();
  }
}
