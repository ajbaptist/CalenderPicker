/// Configuration options for the CalendarPicker widget.
class CalendarConfig {
  /// The start date of the calendar. Defaults to today.
  final DateTime? startDate;

  /// The minimum selectable date. Dates before this will be disabled.
  final DateTime? minDate;

  /// The maximum selectable date. Dates after this will be disabled.
  final DateTime? maxDate;

  /// List of dates that should be disabled (not selectable).
  final List<DateTime> disabledDates;

  /// List of dates that should be highlighted as active/available.
  final List<DateTime> activeDates;

  /// The first day of the week (1 = Monday, 7 = Sunday). Defaults to Monday.
  final int firstDayOfWeek;

  /// The locale for date formatting. Defaults to 'en_US'.
  final String locale;

  /// Whether to enable infinite horizontal scrolling. Defaults to true.
  final bool enableInfiniteScroll;

  /// The number of days to show initially. Only used when infinite scroll is disabled.
  final int? daysCount;

  /// Whether to highlight today. Defaults to true.
  final bool highlightToday;

  /// Whether to highlight weekends. Defaults to false.
  final bool highlightWeekends;

  /// Whether to enable swipe navigation. Defaults to true.
  final bool enableSwipeNavigation;

  /// Whether to show month headers. Defaults to true.
  final bool showMonthHeaders;

  /// The height of the calendar. Defaults to 80.
  final double height;

  /// The width of each date item. Defaults to 60.
  final double itemWidth;

  /// The spacing between date items. Defaults to 4.
  final double itemSpacing;

  const CalendarConfig({
    this.startDate,
    this.minDate,
    this.maxDate,
    this.disabledDates = const [],
    this.activeDates = const [],
    this.firstDayOfWeek = 1, // Monday
    this.locale = 'en_US',
    this.enableInfiniteScroll = true,
    this.daysCount,
    this.highlightToday = true,
    this.highlightWeekends = false,
    this.enableSwipeNavigation = true,
    this.showMonthHeaders = true,
    this.height = 80,
    this.itemWidth = 60,
    this.itemSpacing = 4,
  });

  /// Gets the effective start date, defaulting to today if not specified.
  DateTime get effectiveStartDate => startDate ?? DateTime.now();

  /// Creates a copy of this config with the given changes.
  CalendarConfig copyWith({
    DateTime? startDate,
    DateTime? minDate,
    DateTime? maxDate,
    List<DateTime>? disabledDates,
    List<DateTime>? activeDates,
    int? firstDayOfWeek,
    String? locale,
    bool? enableInfiniteScroll,
    int? daysCount,
    bool? highlightToday,
    bool? highlightWeekends,
    bool? enableSwipeNavigation,
    bool? showMonthHeaders,
    double? height,
    double? itemWidth,
    double? itemSpacing,
  }) {
    return CalendarConfig(
      startDate: startDate ?? this.startDate,
      minDate: minDate ?? this.minDate,
      maxDate: maxDate ?? this.maxDate,
      disabledDates: disabledDates ?? this.disabledDates,
      activeDates: activeDates ?? this.activeDates,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
      locale: locale ?? this.locale,
      enableInfiniteScroll: enableInfiniteScroll ?? this.enableInfiniteScroll,
      daysCount: daysCount ?? this.daysCount,
      highlightToday: highlightToday ?? this.highlightToday,
      highlightWeekends: highlightWeekends ?? this.highlightWeekends,
      enableSwipeNavigation:
          enableSwipeNavigation ?? this.enableSwipeNavigation,
      showMonthHeaders: showMonthHeaders ?? this.showMonthHeaders,
      height: height ?? this.height,
      itemWidth: itemWidth ?? this.itemWidth,
      itemSpacing: itemSpacing ?? this.itemSpacing,
    );
  }

  /// Returns true if the given date is disabled.
  bool isDateDisabled(DateTime date) {
    if (minDate != null && date.isBefore(minDate!)) return true;
    if (maxDate != null && date.isAfter(maxDate!)) return true;

    return disabledDates.any((disabled) =>
        disabled.year == date.year &&
        disabled.month == date.month &&
        disabled.day == date.day);
  }

  /// Returns true if the given date is active.
  bool isDateActive(DateTime date) {
    return activeDates.any((active) =>
        active.year == date.year &&
        active.month == date.month &&
        active.day == date.day);
  }

  /// Returns true if the given date is today.
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Returns true if the given date is a weekend.
  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CalendarConfig &&
        startDate == other.startDate &&
        minDate == other.minDate &&
        maxDate == other.maxDate &&
        disabledDates == other.disabledDates &&
        activeDates == other.activeDates &&
        firstDayOfWeek == other.firstDayOfWeek &&
        locale == other.locale &&
        enableInfiniteScroll == other.enableInfiniteScroll &&
        daysCount == other.daysCount &&
        highlightToday == other.highlightToday &&
        highlightWeekends == other.highlightWeekends &&
        enableSwipeNavigation == other.enableSwipeNavigation &&
        showMonthHeaders == other.showMonthHeaders &&
        height == other.height &&
        itemWidth == other.itemWidth &&
        itemSpacing == other.itemSpacing;
  }

  @override
  int get hashCode =>
      startDate.hashCode ^
      minDate.hashCode ^
      maxDate.hashCode ^
      disabledDates.hashCode ^
      activeDates.hashCode ^
      firstDayOfWeek.hashCode ^
      locale.hashCode ^
      enableInfiniteScroll.hashCode ^
      daysCount.hashCode ^
      highlightToday.hashCode ^
      highlightWeekends.hashCode ^
      enableSwipeNavigation.hashCode ^
      showMonthHeaders.hashCode ^
      height.hashCode ^
      itemWidth.hashCode ^
      itemSpacing.hashCode;

  @override
  String toString() {
    return 'CalendarConfig(startDate: $startDate, minDate: $minDate, maxDate: $maxDate, ...)';
  }
}
