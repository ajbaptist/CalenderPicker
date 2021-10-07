# CalenderPicker

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
    this.width = 60,
    this.height = 70,
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

* [John Baptist](https://github.com/baptistjo01/)