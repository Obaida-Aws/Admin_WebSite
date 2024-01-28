import 'package:adminsite/controller/homescreen_controller/reportsController/ReportPages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportPages extends StatefulWidget {
  @override
  _ReportPagesState createState() => _ReportPagesState();
}

class _ReportPagesState extends State<ReportPages> {
  List<Map<String, String>> reportPagesData = [
    {
      'reportId': '1',
      'pageName': 'Page1',
      'reason': 'Fake Information',
    },
    {
      'reportId': '2',
      'pageName': 'Page2',
      'reason': 'Spam',
    },
    // Add more sample data as needed
  ];

     ReportPagesController pageController = Get.put(ReportPagesController());

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.goTopageReport();
  }
 

  @override
  Widget build(BuildContext context) {
    int reportPagesCount = reportPagesData.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Report Pages: $reportPagesCount',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 120,
              lineWidth: 20,
              percent: calculatePercentage(reportPagesCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$reportPagesCount'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Report ID')),
                  DataColumn(label: Text('Page Name')),
                  DataColumn(label: Text('Reason')),
                ],
                rows: reportPagesData
                    .map(
                      (page) => DataRow(
                        cells: [
                          DataCell(Text(page['reportId'] ?? '')),
                          DataCell(Text(page['pageName'] ?? '')),
                          DataCell(Text(page['reason'] ?? '')),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculatePercentage(int count) {
    double percentage = count / 200.0;
    if (percentage > 1.0) {
      percentage = 1.0;
    }
    return percentage;
  }
}
