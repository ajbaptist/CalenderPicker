import 'package:calender_picker/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horizontal Calendar Demo',
      home: MyHomePage(title: 'Calendar Single Selection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime dateTime = DateTime.now();

  int days = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: const Color(0XFF0342E9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Scheduled Workout',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                  InkWell(
                    onTap: () => Get.bottomSheet(
                        SfDateRangePicker(
                          selectionMode: DateRangePickerSelectionMode.range,
                          view: DateRangePickerView.month,
                          onSelectionChanged: _onSelectionChanged,
                        ),
                        backgroundColor: Colors.white),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0XFFEDF3FF),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.calendar_today,
                            color: Color(0XFF0342E9),
                          ),
                        )),
                  )
                ],
              ),
            ),
            CalenderPicker(
              dateTime,
              daysCount: days,
              // ignore: avoid_print
              enableMultiSelection: true,
              // ignore: avoid_print
              multiSelectionListener: (value) => print(value),
              selectionColor: const Color(0XFF0342E9),
              selectedTextColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  different({DateTime? first, DateTime? last}) async {
    int data = last!.difference(first!).inDays;
    // ignore: avoid_print

    setState(() {
      data++;
      days = data;
      // ignore: avoid_print
      print(data);
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        dateTime = args.value.startDate;

        if (args.value.endDate != null) {
          different(first: args.value.startDate, last: args.value.endDate);
          // ignore: avoid_print
          print(args.value.startDate);
          // ignore: avoid_print
          print(args.value.endDate);
        }
      });
    }
  }
}
