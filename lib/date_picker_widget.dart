import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'date_widget.dart';
import 'extra/color.dart';
import 'extra/style.dart';
import 'gestures/tap.dart';

class CalenderPicker extends StatefulWidget {
  final DateTime startDate;
  final double width;
  final double height;
  final bool enableMultiSelection;
  final Color selectedTextColor;
  final Color selectionColor;
  final TextStyle monthTextStyle;
  final TextStyle dayTextStyle;
  final TextStyle dateTextStyle;
  final DateTime? /*?*/ initialSelectedDate;
  final List<DateTime>? activeDates;
  final DateChangeListener? onDateChange;
  final MultiSelectionListener? multiSelectionListener;
  final int daysCount;
  final String locale;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  CalenderPicker(
    this.startDate, {
    Key? key,
    this.width = 60,
    this.height = 70,
    this.enableMultiSelection = false,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.initialSelectedDate,
    this.multiSelectionListener,
    this.activeDates,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US",
  }) : assert(
            activeDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<StatefulWidget> createState() => _CalenderPickerState();
}

class _CalenderPickerState extends State<CalenderPicker> with AutomaticKeepAliveClientMixin{
  DateTime? _currentDate;

  final ScrollController _controller = ScrollController();

  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;

  @override
  void initState() {
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);
    // Set initial Values
    _currentDate = widget.initialSelectedDate;

    selectedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.selectedTextColor);
    selectedMonthStyle =
        widget.monthTextStyle.copyWith(color: widget.selectedTextColor);
    selectedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.selectedTextColor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: widget.height,
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: ListView.builder(
          itemCount: widget.daysCount,
          addAutomaticKeepAlives: true,
          scrollDirection: Axis.horizontal,
          controller: _controller,
          itemBuilder: (context, index) {
            DateTime date;
            DateTime _date = widget.startDate.add(Duration(days: index));
            date = DateTime(_date.year, _date.month, _date.day);
      
            final bool isSelected =
                _currentDate != null ? _compareDate(date, _currentDate!) : false;
      
            // Return the Date Widget
            return DateWidget(
              date: date,
              monthTextStyle:
                  isSelected ? selectedMonthStyle : widget.monthTextStyle,
              dateTextStyle:
                  isSelected ? selectedDateStyle : widget.dateTextStyle,
              dayTextStyle: isSelected ? selectedDayStyle : widget.dayTextStyle,
              width: widget.width,
              locale: widget.locale,
              isMultiSelectionEnable: widget.enableMultiSelection,
              activeColor: widget.selectionColor,
              activeDateStyle: selectedDateStyle,
      
              activeDayStyle: selectedDayStyle,
              //for color change
              selectionColor:
                  isSelected ? widget.selectionColor : const Color(0XFFEDF3FF),
      
              multiSelectionListener: (value) {
                setState(() {
                  if (widget.multiSelectionListener != null) {
                    widget.multiSelectionListener!(list);
                  }
                });
              },
      
              onDateSelected: (selectedDate) {
                //make changes
                if (widget.enableMultiSelection == false) {
                  if (widget.onDateChange != null) {
                    widget.onDateChange!(selectedDate);
                  }
                  setState(() {
                    _currentDate = selectedDate;
                    // ignore: avoid_print                
                  });
                } else {
                  setState(() {
                    if (widget.multiSelectionListener != null) {
                      widget.multiSelectionListener!(list);
                    }
                  });
                }
              },
            );
          },
        ),
      ),
    );
  }

  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  @override
  bool get wantKeepAlive => true;
}

List list = [];
bool isSelect = false;


class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}