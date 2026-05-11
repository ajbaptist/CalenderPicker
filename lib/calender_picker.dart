/// A modern, customizable Flutter calendar picker with horizontal timeline,
/// single/multi-date selection, date ranges, and extensive customization options.
///
/// ## Features
///
/// - Horizontal timeline calendar
/// - Single date selection
/// - Multi-date selection
/// - Date range selection
/// - Min/Max date restrictions
/// - Disabled and blackout dates
/// - Today and weekend highlighting
/// - Month switching with infinite scrolling
/// - Swipe navigation
/// - Custom first day of week
/// - Full customization (colors, typography, spacing, etc.)
/// - RTL support
/// - Full locale support
/// - Accessibility features
/// - Material 3 support
/// - Dark mode support
///
/// ## Usage
///
/// ```dart
/// CalendarPicker(
///   startDate: DateTime.now(),
///   selectionMode: CalendarSelectionMode.single,
///   onDateSelected: (date) {
///     print('Selected: $date');
///   },
/// )
/// ```
library calender_picker;

export 'src/calendar_picker.dart';
export 'src/controllers/calendar_controller.dart';
export 'src/models/calendar_config.dart';
export 'src/models/calendar_selection.dart';
export 'src/models/calendar_style.dart';
export 'src/theme/calendar_theme.dart';
export 'src/utils/date_utils.dart';
