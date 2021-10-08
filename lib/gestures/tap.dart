/// Signature for a function that detects when a tap is occurred.

typedef DateSelectionCallback = void Function(DateTime selectedDate);

/// Signature for a function that is called when selected date is changed

typedef DateChangeListener = void Function(DateTime selectedDate);

///signature for multiple dates are selected
///
typedef MultiSelectionListener = void Function(List selectedDates);

typedef BoolListener = void Function(bool isMultiSelect, DateTime dateTime);
