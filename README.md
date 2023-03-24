# CalenderPicker

[![pub package](https://img.shields.io/pub/v/calender_picker.svg)](https://pub.dartlang.org/packages/calender_picker)

💥 Flutter CalenderPicker Library that provides a calendar as a horizontal timeline and single section and multiple selections options also available 💥


## App Demo
| | | |
|----|-----|-----|
|![calender_picker](https://github.com/baptistjo01/CalenderPicker/blob/main/screenshots/calender%20picker.jpg)|![Edited_20210517_233106](https://github.com/baptistjo01/CalenderPicker/blob/main/screenshots/multi%20selection.jpg)|



# Let's get started

## How To Use

Import the following package in your dart file

```dart
import 'package:calender_picker/calender_picker.dart';
```

## Usage

This version is breaking backwards compatibility

Use the `CalenderPicker` Widget

```dart
Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CalenderPicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.black,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          // New date selected
          setState(() {
            _selectedValue = date;
          });
        },
      ),
    ],
)
```

##### Constructor:

```dart
 CalenderPicker(
    this.startDate, {
    Key? key,
    this.enableMultiSelection = false,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.initialSelectedDate,
    this.activeDates,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US",
}) : super(key: key);
```

Author
------

* [John Baptist](https://github.com/ajbaptist/)