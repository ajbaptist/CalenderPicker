import 'package:flutter/material.dart';

import '../models/calendar_style.dart';

/// Theme data for the CalendarPicker widget.
class CalendarTheme extends InheritedWidget {
  /// The style configuration for the calendar.
  final CalendarStyle style;

  const CalendarTheme({
    super.key,
    required this.style,
    required super.child,
  });

  /// Gets the calendar theme from the context.
  static CalendarTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CalendarTheme>();
  }

  /// Gets the calendar style from the context.
  static CalendarStyle styleOf(BuildContext context) {
    final theme = of(context);
    return theme?.style ?? const CalendarStyle();
  }

  @override
  bool updateShouldNotify(CalendarTheme oldWidget) {
    return style != oldWidget.style;
  }
}

/// Extension on BuildContext to easily access calendar theme.
extension CalendarThemeExtension on BuildContext {
  /// Gets the calendar style from the current context.
  CalendarStyle get calendarStyle => CalendarTheme.styleOf(this);
}
