/// Represents the selection mode for the calendar picker.
enum CalendarSelectionMode {
  /// Allows selecting a single date.
  single,

  /// Allows selecting multiple dates.
  multiple,

  /// Allows selecting a date range (start and end dates).
  range,
}

/// Represents the current selection state of the calendar.
class CalendarSelection {
  /// The selected dates. For single mode, this will contain at most one date.
  /// For multiple mode, it can contain multiple dates.
  /// For range mode, it represents the start and end dates.
  final List<DateTime> selectedDates;

  /// The start date of the range (only used in range mode).
  final DateTime? rangeStart;

  /// The end date of the range (only used in range mode).
  final DateTime? rangeEnd;

  const CalendarSelection({
    this.selectedDates = const [],
    this.rangeStart,
    this.rangeEnd,
  });

  /// Creates a selection for single date mode.
  factory CalendarSelection.single(DateTime? date) {
    return CalendarSelection(
      selectedDates: date != null ? [date] : [],
    );
  }

  /// Creates a selection for multiple dates mode.
  factory CalendarSelection.multiple(List<DateTime> dates) {
    return CalendarSelection(selectedDates: dates);
  }

  /// Creates a selection for range mode.
  factory CalendarSelection.range(DateTime? start, DateTime? end) {
    return CalendarSelection(
      selectedDates: [if (start != null) start, if (end != null) end],
      rangeStart: start,
      rangeEnd: end,
    );
  }

  /// Returns the single selected date, or null if no date is selected.
  DateTime? get singleDate =>
      selectedDates.isNotEmpty ? selectedDates.first : null;

  /// Returns true if the selection contains the given date.
  bool contains(DateTime date) {
    return selectedDates.any((selected) =>
        selected.year == date.year &&
        selected.month == date.month &&
        selected.day == date.day);
  }

  /// Returns true if the date is within the selected range (inclusive).
  bool isInRange(DateTime date) {
    if (rangeStart == null || rangeEnd == null) return false;

    final normalizedDate = DateTime(date.year, date.month, date.day);
    final start =
        DateTime(rangeStart!.year, rangeStart!.month, rangeStart!.day);
    final end = DateTime(rangeEnd!.year, rangeEnd!.month, rangeEnd!.day);

    return normalizedDate.isAtSameMomentAs(start) ||
        normalizedDate.isAtSameMomentAs(end) ||
        (normalizedDate.isAfter(start) && normalizedDate.isBefore(end));
  }

  /// Returns true if the date is the start of the range.
  bool isRangeStart(DateTime date) {
    if (rangeStart == null) return false;
    return date.year == rangeStart!.year &&
        date.month == rangeStart!.month &&
        date.day == rangeStart!.day;
  }

  /// Returns true if the date is the end of the range.
  bool isRangeEnd(DateTime date) {
    if (rangeEnd == null) return false;
    return date.year == rangeEnd!.year &&
        date.month == rangeEnd!.month &&
        date.day == rangeEnd!.day;
  }

  /// Creates a copy of this selection with the given changes.
  CalendarSelection copyWith({
    List<DateTime>? selectedDates,
    DateTime? rangeStart,
    DateTime? rangeEnd,
  }) {
    return CalendarSelection(
      selectedDates: selectedDates ?? this.selectedDates,
      rangeStart: rangeStart ?? this.rangeStart,
      rangeEnd: rangeEnd ?? this.rangeEnd,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CalendarSelection &&
        _listEquals(selectedDates, other.selectedDates) &&
        rangeStart == other.rangeStart &&
        rangeEnd == other.rangeEnd;
  }

  @override
  int get hashCode =>
      selectedDates.hashCode ^ rangeStart.hashCode ^ rangeEnd.hashCode;

  bool _listEquals(List<DateTime> a, List<DateTime> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'CalendarSelection(selectedDates: $selectedDates, rangeStart: $rangeStart, rangeEnd: $rangeEnd)';
  }
}
