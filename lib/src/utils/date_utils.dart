import 'package:intl/intl.dart';

/// Utility functions for date operations.
class CalendarDateUtils {
  /// Formats a date using the given pattern and locale.
  static String formatDate(DateTime date, String pattern, String locale) {
    return DateFormat(pattern, locale).format(date);
  }

  /// Gets the abbreviated weekday name for the given date.
  static String getWeekdayName(DateTime date, String locale) {
    return DateFormat.E(locale).format(date).toUpperCase();
  }

  /// Gets the month name for the given date.
  static String getMonthName(DateTime date, String locale) {
    return DateFormat.MMMM(locale).format(date);
  }

  /// Checks if two dates are the same day.
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Checks if the date is today.
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return isSameDay(date, now);
  }

  /// Checks if the date is a weekend.
  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  /// Gets the start of the week for the given date and first day of week.
  static DateTime getStartOfWeek(DateTime date, int firstDayOfWeek) {
    // Adjust firstDayOfWeek to match DateTime weekday (1 = Monday, 7 = Sunday)
    int adjustedFirstDay = firstDayOfWeek == 7 ? 0 : firstDayOfWeek;

    int weekday = date.weekday;
    int daysToSubtract = (weekday - adjustedFirstDay) % 7;

    return DateTime(date.year, date.month, date.day - daysToSubtract);
  }

  /// Gets the end of the week for the given date and first day of week.
  static DateTime getEndOfWeek(DateTime date, int firstDayOfWeek) {
    DateTime startOfWeek = getStartOfWeek(date, firstDayOfWeek);
    return startOfWeek.add(const Duration(days: 6));
  }

  /// Gets all dates in the given month.
  static List<DateTime> getDatesInMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);

    final dates = <DateTime>[];
    for (int i = 0; i <= lastDay.difference(firstDay).inDays; i++) {
      dates.add(firstDay.add(Duration(days: i)));
    }

    return dates;
  }

  /// Gets all dates in the given week.
  static List<DateTime> getDatesInWeek(DateTime date, int firstDayOfWeek) {
    final startOfWeek = getStartOfWeek(date, firstDayOfWeek);

    final dates = <DateTime>[];
    for (int i = 0; i < 7; i++) {
      dates.add(startOfWeek.add(Duration(days: i)));
    }

    return dates;
  }

  /// Calculates the number of days between two dates.
  static int daysBetween(DateTime start, DateTime end) {
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);
    return endDate.difference(startDate).inDays;
  }

  /// Adds days to a date.
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// Subtracts days from a date.
  static DateTime subtractDays(DateTime date, int days) {
    return date.subtract(Duration(days: days));
  }

  /// Gets the date at the start of the month.
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Gets the date at the end of the month.
  static DateTime getEndOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  /// Checks if a date is within a range (inclusive).
  static bool isDateInRange(DateTime date, DateTime start, DateTime end) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedStart = DateTime(start.year, start.month, start.day);
    final normalizedEnd = DateTime(end.year, end.month, end.day);

    return normalizedDate.isAtSameMomentAs(normalizedStart) ||
        normalizedDate.isAtSameMomentAs(normalizedEnd) ||
        (normalizedDate.isAfter(normalizedStart) &&
            normalizedDate.isBefore(normalizedEnd));
  }

  /// Gets the week number of the year for the given date.
  static int getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = daysBetween(firstDayOfYear, date);
    return ((daysSinceFirstDay + firstDayOfYear.weekday - 1) / 7).floor() + 1;
  }

  /// Gets the quarter of the year for the given date.
  static int getQuarter(DateTime date) {
    return ((date.month - 1) / 3).floor() + 1;
  }
}
