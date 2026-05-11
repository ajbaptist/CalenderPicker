import 'package:flutter/material.dart';

/// Style configuration for the CalendarPicker widget.
class CalendarStyle {
  /// Colors
  final Color backgroundColor;
  final Color selectedColor;
  final Color todayColor;
  final Color weekendColor;
  final Color disabledColor;
  final Color activeColor;
  final Color rangeColor;
  final Color rangeStartColor;
  final Color rangeEndColor;

  /// Text styles
  final TextStyle dayTextStyle;
  final TextStyle dateTextStyle;
  final TextStyle monthTextStyle;
  final TextStyle selectedDayTextStyle;
  final TextStyle selectedDateTextStyle;
  final TextStyle selectedMonthTextStyle;
  final TextStyle todayDayTextStyle;
  final TextStyle todayDateTextStyle;
  final TextStyle todayMonthTextStyle;
  final TextStyle disabledDayTextStyle;
  final TextStyle disabledDateTextStyle;
  final TextStyle disabledMonthTextStyle;
  final TextStyle weekendDayTextStyle;
  final TextStyle weekendDateTextStyle;
  final TextStyle weekendMonthTextStyle;

  /// Decorations
  final BoxDecoration selectedDecoration;
  final BoxDecoration todayDecoration;
  final BoxDecoration disabledDecoration;
  final BoxDecoration weekendDecoration;
  final BoxDecoration rangeDecoration;
  final BoxDecoration rangeStartDecoration;
  final BoxDecoration rangeEndDecoration;
  final BoxDecoration defaultDecoration;

  /// Spacing and sizing
  final EdgeInsets itemPadding;
  final double itemBorderRadius;
  final double headerHeight;

  const CalendarStyle({
    // Colors
    this.backgroundColor = Colors.transparent,
    this.selectedColor = const Color(0xFF1976D2),
    this.todayColor = const Color(0xFF42A5F5),
    this.weekendColor = const Color(0xFFFF7043),
    this.disabledColor = const Color(0xFFBDBDBD),
    this.activeColor = const Color(0xFF4CAF50),
    this.rangeColor = const Color(0xFFBBDEFB),
    this.rangeStartColor = const Color(0xFF1976D2),
    this.rangeEndColor = const Color(0xFF1976D2),

    // Text styles
    this.dayTextStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),
    this.dateTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    this.monthTextStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),
    this.selectedDayTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    ),
    this.selectedDateTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    this.selectedMonthTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    ),
    this.todayDayTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    ),
    this.todayDateTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    this.todayMonthTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    ),
    this.disabledDayTextStyle = const TextStyle(
      color: Colors.black38,
      fontSize: 11,
      fontWeight: FontWeight.w400,
    ),
    this.disabledDateTextStyle = const TextStyle(
      color: Colors.black38,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    this.disabledMonthTextStyle = const TextStyle(
      color: Colors.black26,
      fontSize: 11,
      fontWeight: FontWeight.w400,
    ),
    this.weekendDayTextStyle = const TextStyle(
      color: Colors.deepOrange,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),
    this.weekendDateTextStyle = const TextStyle(
      color: Colors.deepOrange,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    this.weekendMonthTextStyle = const TextStyle(
      color: Colors.deepOrange,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),

    // Decorations
    this.selectedDecoration = const BoxDecoration(
      color: Color(0xFF1976D2),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    this.todayDecoration = const BoxDecoration(
      color: Color(0xFF42A5F5),
      borderRadius: BorderRadius.all(Radius.circular(25)),
      border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)),
    ),
    this.disabledDecoration = const BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    this.weekendDecoration = const BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    this.rangeDecoration = const BoxDecoration(
      color: Color(0xFFBBDEFB),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    this.rangeStartDecoration = const BoxDecoration(
      color: Color(0xFF1976D2),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    this.rangeEndDecoration = const BoxDecoration(
      color: Color(0xFF1976D2),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    this.defaultDecoration = const BoxDecoration(
      color: Color(0xFFF8F9FA),
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),

    // Spacing and sizing
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.itemBorderRadius = 25,
    this.headerHeight = 24,
  });

  /// Creates a copy of this style with the given changes.
  CalendarStyle copyWith({
    // Colors
    Color? backgroundColor,
    Color? selectedColor,
    Color? todayColor,
    Color? weekendColor,
    Color? disabledColor,
    Color? activeColor,
    Color? rangeColor,
    Color? rangeStartColor,
    Color? rangeEndColor,

    // Text styles
    TextStyle? dayTextStyle,
    TextStyle? dateTextStyle,
    TextStyle? monthTextStyle,
    TextStyle? selectedDayTextStyle,
    TextStyle? selectedDateTextStyle,
    TextStyle? selectedMonthTextStyle,
    TextStyle? todayDayTextStyle,
    TextStyle? todayDateTextStyle,
    TextStyle? todayMonthTextStyle,
    TextStyle? disabledDayTextStyle,
    TextStyle? disabledDateTextStyle,
    TextStyle? disabledMonthTextStyle,
    TextStyle? weekendDayTextStyle,
    TextStyle? weekendDateTextStyle,
    TextStyle? weekendMonthTextStyle,

    // Decorations
    BoxDecoration? selectedDecoration,
    BoxDecoration? todayDecoration,
    BoxDecoration? disabledDecoration,
    BoxDecoration? weekendDecoration,
    BoxDecoration? rangeDecoration,
    BoxDecoration? rangeStartDecoration,
    BoxDecoration? rangeEndDecoration,
    BoxDecoration? defaultDecoration,

    // Spacing and sizing
    EdgeInsets? itemPadding,
    double? itemBorderRadius,
    double? headerHeight,
  }) {
    return CalendarStyle(
      // Colors
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedColor: selectedColor ?? this.selectedColor,
      todayColor: todayColor ?? this.todayColor,
      weekendColor: weekendColor ?? this.weekendColor,
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      rangeColor: rangeColor ?? this.rangeColor,
      rangeStartColor: rangeStartColor ?? this.rangeStartColor,
      rangeEndColor: rangeEndColor ?? this.rangeEndColor,

      // Text styles
      dayTextStyle: dayTextStyle ?? this.dayTextStyle,
      dateTextStyle: dateTextStyle ?? this.dateTextStyle,
      monthTextStyle: monthTextStyle ?? this.monthTextStyle,
      selectedDayTextStyle: selectedDayTextStyle ?? this.selectedDayTextStyle,
      selectedDateTextStyle:
          selectedDateTextStyle ?? this.selectedDateTextStyle,
      selectedMonthTextStyle:
          selectedMonthTextStyle ?? this.selectedMonthTextStyle,
      todayDayTextStyle: todayDayTextStyle ?? this.todayDayTextStyle,
      todayDateTextStyle: todayDateTextStyle ?? this.todayDateTextStyle,
      todayMonthTextStyle: todayMonthTextStyle ?? this.todayMonthTextStyle,
      disabledDayTextStyle: disabledDayTextStyle ?? this.disabledDayTextStyle,
      disabledDateTextStyle:
          disabledDateTextStyle ?? this.disabledDateTextStyle,
      disabledMonthTextStyle:
          disabledMonthTextStyle ?? this.disabledMonthTextStyle,
      weekendDayTextStyle: weekendDayTextStyle ?? this.weekendDayTextStyle,
      weekendDateTextStyle: weekendDateTextStyle ?? this.weekendDateTextStyle,
      weekendMonthTextStyle:
          weekendMonthTextStyle ?? this.weekendMonthTextStyle,

      // Decorations
      selectedDecoration: selectedDecoration ?? this.selectedDecoration,
      todayDecoration: todayDecoration ?? this.todayDecoration,
      disabledDecoration: disabledDecoration ?? this.disabledDecoration,
      weekendDecoration: weekendDecoration ?? this.weekendDecoration,
      rangeDecoration: rangeDecoration ?? this.rangeDecoration,
      rangeStartDecoration: rangeStartDecoration ?? this.rangeStartDecoration,
      rangeEndDecoration: rangeEndDecoration ?? this.rangeEndDecoration,
      defaultDecoration: defaultDecoration ?? this.defaultDecoration,

      // Spacing and sizing
      itemPadding: itemPadding ?? this.itemPadding,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      headerHeight: headerHeight ?? this.headerHeight,
    );
  }

  /// Creates a dark theme style.
  factory CalendarStyle.dark() {
    return const CalendarStyle(
      backgroundColor: Color(0xFF121212),
      selectedColor: Color(0xFF64B5F6),
      todayColor: Color(0xFF42A5F5),
      weekendColor: Color(0xFFFF8A65),
      disabledColor: Color(0xFF424242),
      activeColor: Color(0xFF81C784),
      rangeColor: Color(0xFF37474F),
      rangeStartColor: Color(0xFF64B5F6),
      rangeEndColor: Color(0xFF64B5F6),
      dayTextStyle: TextStyle(
        color: Colors.white70,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      dateTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      monthTextStyle: TextStyle(
        color: Colors.white54,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      selectedDayTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      selectedDateTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      selectedMonthTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      todayDayTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      todayDateTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      todayMonthTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      disabledDayTextStyle: TextStyle(
        color: Colors.white38,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
      disabledDateTextStyle: TextStyle(
        color: Colors.white38,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      disabledMonthTextStyle: TextStyle(
        color: Colors.white24,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
      weekendDayTextStyle: TextStyle(
        color: Color(0xFFFF8A65),
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      weekendDateTextStyle: TextStyle(
        color: Color(0xFFFF8A65),
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      weekendMonthTextStyle: TextStyle(
        color: Color(0xFFFF8A65),
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
      defaultDecoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      disabledDecoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      weekendDecoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
    );
  }

  /// Creates a Material 3 style.
  factory CalendarStyle.material3() {
    return const CalendarStyle(
      selectedColor: Color(0xFF6750A4),
      todayColor: Color(0xFF625B71),
      weekendColor: Color(0xFFD32F2F),
      disabledColor: Color(0xFFCAC4D0),
      activeColor: Color(0xFF4CAF50),
      rangeColor: Color(0xFFE7E0EC),
      rangeStartColor: Color(0xFF6750A4),
      rangeEndColor: Color(0xFF6750A4),
      selectedDecoration: BoxDecoration(
        color: Color(0xFF6750A4),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      todayDecoration: BoxDecoration(
        color: Color(0xFF625B71),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.fromBorderSide(
            BorderSide(color: Color(0xFFE6E1E5), width: 1)),
      ),
      disabledDecoration: BoxDecoration(
        color: Color(0xFFF7F2FA),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      weekendDecoration: BoxDecoration(
        color: Color(0xFFFFEBEE),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      rangeDecoration: BoxDecoration(
        color: Color(0xFFE7E0EC),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      rangeStartDecoration: BoxDecoration(
        color: Color(0xFF6750A4),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      rangeEndDecoration: BoxDecoration(
        color: Color(0xFF6750A4),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      defaultDecoration: BoxDecoration(
        color: Color(0xFFF7F2FA),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      itemBorderRadius: 16,
    );
  }
}
