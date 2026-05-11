import 'dart:async';
import '../models/calendar_config.dart';
import '../models/calendar_selection.dart';

/// Controller for managing calendar picker state and events.
class CalendarController {
  /// The current selection state.
  CalendarSelection _selection = CalendarSelection.single(null);

  /// The calendar configuration.
  final CalendarConfig config;

  /// Stream controller for selection changes.
  final StreamController<CalendarSelection> _selectionController =
      StreamController<CalendarSelection>.broadcast();

  /// Stream controller for month changes.
  final StreamController<DateTime> _monthController =
      StreamController<DateTime>.broadcast();

  CalendarController({CalendarConfig? config})
      : config = config ?? const CalendarConfig();

  /// Gets the current selection.
  CalendarSelection get selection => _selection;
  set selection(CalendarSelection value) {
    _selection = value;
    _selectionController.add(value);
  }

  /// Stream of selection changes.
  Stream<CalendarSelection> get selectionStream => _selectionController.stream;

  /// Stream of month changes.
  Stream<DateTime> get monthStream => _monthController.stream;

  /// Selects a single date.
  void selectDate(DateTime date) {
    if (config.isDateDisabled(date)) return;

    _selection = CalendarSelection.single(date);
    _selectionController.add(_selection);
  }

  /// Toggles a date in multi-selection mode.
  void toggleDate(DateTime date) {
    if (config.isDateDisabled(date)) return;

    final dates = List<DateTime>.from(_selection.selectedDates);
    final existingIndex = dates.indexWhere(
        (d) => d.year == date.year && d.month == date.month && d.day == date.day);

    if (existingIndex >= 0) {
      dates.removeAt(existingIndex);
    } else {
      dates.add(date);
    }

    _selection = CalendarSelection.multiple(dates);
    _selectionController.add(_selection);
  }

  /// Sets multiple dates.
  void selectDates(List<DateTime> dates) {
    final validDates = dates.where((date) => !config.isDateDisabled(date)).toList();
    _selection = CalendarSelection.multiple(validDates);
    _selectionController.add(_selection);
  }

  /// Sets a date range.
  void selectRange(DateTime? start, DateTime? end) {
    if (start != null && config.isDateDisabled(start)) return;
    if (end != null && config.isDateDisabled(end)) return;

    _selection = CalendarSelection.range(start, end);
    _selectionController.add(_selection);
  }

  /// Clears the current selection.
  void clearSelection() {
    _selection = const CalendarSelection();
    _selectionController.add(_selection);
  }

  /// Notifies that the month has changed.
  void notifyMonthChanged(DateTime month) {
    _monthController.add(month);
  }

  /// Disposes the controller and closes streams.
  void dispose() {
    _selectionController.close();
    _monthController.close();
  }
}