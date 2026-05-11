import 'package:calender_picker/calender_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const CalendarPickerDemo());
}

class CalendarPickerDemo extends StatelessWidget {
  const CalendarPickerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar Picker Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
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

  DateTime? _selectedDate;
  List<DateTime> _selectedDates = [];
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  final _dateFormat = DateFormat('dd MMM yyyy');

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

  String _formatDate(DateTime? date) {
    if (date == null) return 'None';
    return _dateFormat.format(date);
  }

  void _showMessage(String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Picker Demo'),
        centerTitle: true,
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

  Widget _buildSection({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildSingleSelectionTab() {
    return _buildSection(
      title: 'Single Date Selection',
      subtitle: 'Selected: ${_formatDate(_selectedDate)}',
      child: SizedBox(
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
            _showMessage('Selected: ${_formatDate(date)}');
          },
        ),
      ),
    );
  }

  Widget _buildMultipleSelectionTab() {
    return _buildSection(
      title: 'Multiple Date Selection',
      subtitle: 'Selected Dates: ${_selectedDates.length}',
      child: SizedBox(
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
            _showMessage('Selected ${dates.length} dates');
          },
        ),
      ),
    );
  }

  Widget _buildRangeSelectionTab() {
    return _buildSection(
      title: 'Range Selection',
      subtitle: '${_formatDate(_rangeStart)} → ${_formatDate(_rangeEnd)}',
      child: SizedBox(
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
              _showMessage(
                  'Range: ${_formatDate(start)} to ${_formatDate(end)}');
            }
          },
        ),
      ),
    );
  }

  Widget _buildCustomStyleTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Dark Style',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
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
                _showMessage('Selected: ${_formatDate(date)}');
              },
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Material 3 Style',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
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
                _showMessage('Selected: ${_formatDate(date)}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
