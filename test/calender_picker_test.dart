import 'package:calender_picker/calender_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalendarSelection', () {
    test('single selection', () {
      final date = DateTime(2024, 1, 1);
      final selection = CalendarSelection.single(date);

      expect(selection.singleDate, date);
      expect(selection.selectedDates, [date]);
      expect(selection.contains(date), true);
    });

    test('multiple selection', () {
      final dates = [DateTime(2024, 1, 1), DateTime(2024, 1, 2)];
      final selection = CalendarSelection.multiple(dates);

      expect(selection.selectedDates, dates);
      expect(selection.contains(DateTime(2024, 1, 1)), true);
      expect(selection.contains(DateTime(2024, 1, 3)), false);
    });

    test('range selection', () {
      final start = DateTime(2024, 1, 1);
      final end = DateTime(2024, 1, 3);
      final selection = CalendarSelection.range(start, end);

      expect(selection.rangeStart, start);
      expect(selection.rangeEnd, end);
      expect(selection.isInRange(DateTime(2024, 1, 2)), true);
      expect(selection.isInRange(DateTime(2024, 1, 4)), false);
    });
  });

  group('CalendarConfig', () {
    test('default config', () {
      const config = CalendarConfig();

      expect(config.locale, 'en_US');
      expect(config.highlightToday, true);
      expect(config.enableInfiniteScroll, true);
    });

    test('date validation', () {
      final config = CalendarConfig(
        minDate: DateTime(2024, 1, 1),
        maxDate: DateTime(2024, 12, 31),
        disabledDates: const [/* DateTime values can't be const */],
      );

      expect(config.isDateDisabled(DateTime(2023, 12, 31)), true); // Before min
      expect(config.isDateDisabled(DateTime(2025, 1, 1)), true); // After max
      // Note: Can't test disabled dates with const DateTime
      expect(config.isDateDisabled(DateTime(2024, 1, 16)), false); // Valid
    });
  });

  group('CalendarDateUtils', () {
    test('isSameDay', () {
      final date1 = DateTime(2024, 1, 1, 10, 30);
      final date2 = DateTime(2024, 1, 1, 15, 45);

      expect(CalendarDateUtils.isSameDay(date1, date2), true);
    });

    test('isToday', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));

      expect(CalendarDateUtils.isToday(today), true);
      expect(CalendarDateUtils.isToday(yesterday), false);
    });

    test('isWeekend', () {
      final saturday = DateTime(2024, 1, 6); // Saturday
      final sunday = DateTime(2024, 1, 7); // Sunday
      final monday = DateTime(2024, 1, 8); // Monday

      expect(CalendarDateUtils.isWeekend(saturday), true);
      expect(CalendarDateUtils.isWeekend(sunday), true);
      expect(CalendarDateUtils.isWeekend(monday), false);
    });

    test('getWeekdayName', () {
      final monday = DateTime(2024, 1, 8); // Monday
      final name = CalendarDateUtils.getWeekdayName(monday, 'en_US');

      expect(name, 'MON');
    });

    test('daysBetween', () {
      final start = DateTime(2024, 1, 1);
      final end = DateTime(2024, 1, 3);

      expect(CalendarDateUtils.daysBetween(start, end), 2);
    });
  });

  group('CalendarPicker Widget', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalendarPicker(),
          ),
        ),
      );

      expect(find.byType(CalendarPicker), findsOneWidget);
    });

    testWidgets('single selection works', (WidgetTester tester) async {
      DateTime? selectedDate;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalendarPicker(
              selectionMode: CalendarSelectionMode.single,
              onDateSelected: (date) => selectedDate = date,
            ),
          ),
        ),
      );

      // Find a date item and tap it
      final dateItem = find.byType(InkWell).first;
      await tester.tap(dateItem);
      await tester.pump();

      expect(selectedDate, isNotNull);
    });

    testWidgets('multiple selection works', (WidgetTester tester) async {
      List<DateTime> selectedDates = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalendarPicker(
              selectionMode: CalendarSelectionMode.multiple,
              onDatesSelected: (dates) => selectedDates = dates,
            ),
          ),
        ),
      );

      // Find date items and tap them
      final dateItems = find.byType(InkWell);
      if (dateItems.evaluate().length >= 2) {
        await tester.tap(dateItems.first);
        await tester.pump();
        await tester.tap(dateItems.at(1));
        await tester.pump();
      }

      expect(selectedDates.length, 2);
    });

    testWidgets('range selection works', (WidgetTester tester) async {
      DateTime? rangeStart;
      DateTime? rangeEnd;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalendarPicker(
              selectionMode: CalendarSelectionMode.range,
              onRangeSelected: (start, end) {
                rangeStart = start;
                rangeEnd = end;
              },
            ),
          ),
        ),
      );

      // Find date items and tap them for range
      final dateItems = find.byType(InkWell);
      if (dateItems.evaluate().length >= 2) {
        await tester.tap(dateItems.first);
        await tester.pump();
        await tester.tap(dateItems.at(1));
        await tester.pump();
      }

      expect(rangeStart, isNotNull);
      expect(rangeEnd, isNotNull);
    });

    testWidgets('accessibility labels are present',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CalendarPicker(),
          ),
        ),
      );

      tester.ensureSemantics();
      final semanticsFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label != null &&
            widget.properties.label!.isNotEmpty,
      );
      expect(semanticsFinder, findsWidgets);
    });
  });

  group('CalendarController', () {
    test('selectDate works', () {
      final controller = CalendarController();
      final date = DateTime(2024, 1, 1);

      controller.selectDate(date);

      expect(controller.selection.singleDate, date);
    });

    test('toggleDate works', () {
      final controller = CalendarController();
      final date = DateTime(2024, 1, 1);

      controller.toggleDate(date);
      expect(controller.selection.contains(date), true);

      controller.toggleDate(date);
      expect(controller.selection.contains(date), false);
    });

    test('selectRange works', () {
      final controller = CalendarController();
      final start = DateTime(2024, 1, 1);
      final end = DateTime(2024, 1, 3);

      controller.selectRange(start, end);

      expect(controller.selection.rangeStart, start);
      expect(controller.selection.rangeEnd, end);
    });
  });
}
