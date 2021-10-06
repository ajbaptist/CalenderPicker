import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'gestures/tap.dart';

class DateWidget extends StatefulWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  DateWidget({
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: widget.width,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: widget.selectionColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  DateFormat("EEE", widget.locale)
                      .format(widget.date)
                      .substring(0, 1)
                      .toUpperCase(), // WeekDay
                  style: widget.dayTextStyle),
              Text(widget.date.day.toString(), // Date
                  style: widget.dateTextStyle),
            ],
          ),
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (widget.onDateSelected != null) {
          // Call the onDateSelected Function
          widget.onDateSelected!(widget.date);
        }
      },
    );
  }
}
