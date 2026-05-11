import 'package:calender_picker/calender_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalendarPickerDemo());
}

class CalendarPickerDemo extends StatelessWidget {
  const CalendarPickerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar Picker Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final CalendarSelectionMode _selectionMode = CalendarSelectionMode.single;
  DateTime? _selectedDate;
  List<DateTime> _selectedDates = [];
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Picker Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Single'),
            Tab(text: 'Multiple'),
            Tab(text: 'Range'),
            Tab(text: 'Custom'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSingleSelectionTab(),
          _buildMultipleSelectionTab(),
          _buildRangeSelectionTab(),
          _buildCustomStyleTab(),
        ],
      ),
    );
  }

  Widget _buildSingleSelectionTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Single Date Selection',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Selected: ${_selectedDate?.toString() ?? 'None'}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: CalendarPicker(
              selectionMode: CalendarSelectionMode.single,
              config: const CalendarConfig(
                locale: 'en_US',
                highlightToday: true,
                highlightWeekends: true,
              ),
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: $date')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleSelectionTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Multiple Date Selection',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Selected: ${_selectedDates.length} dates',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: CalendarPicker(
              selectionMode: CalendarSelectionMode.multiple,
              config: const CalendarConfig(
                locale: 'en_US',
                highlightToday: true,
                highlightWeekends: true,
              ),
              onDatesSelected: (dates) {
                setState(() {
                  _selectedDates = dates;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected ${dates.length} dates')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRangeSelectionTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date Range Selection',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Range: ${_rangeStart?.toString() ?? 'None'} - ${_rangeEnd?.toString() ?? 'None'}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: CalendarPicker(
              selectionMode: CalendarSelectionMode.range,
              config: const CalendarConfig(
                locale: 'en_US',
                highlightToday: true,
                highlightWeekends: true,
              ),
              onRangeSelected: (start, end) {
                setState(() {
                  _rangeStart = start;
                  _rangeEnd = end;
                });
                if (start != null && end != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Range: $start to $end')),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomStyleTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Style (Dark Theme)',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: CalendarPicker(
              selectionMode: CalendarSelectionMode.single,
              config: const CalendarConfig(
                locale: 'en_US',
                highlightToday: true,
                highlightWeekends: true,
              ),
              style: CalendarStyle.dark().copyWith(
                selectedColor: Colors.purple,
                todayColor: Colors.orange,
              ),
              onDateSelected: (date) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: $date')),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Material 3 Style',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: CalendarPicker(
              selectionMode: CalendarSelectionMode.single,
              config: const CalendarConfig(
                locale: 'en_US',
                highlightToday: true,
                highlightWeekends: true,
              ),
              style: CalendarStyle.material3(),
              onDateSelected: (date) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: $date')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
