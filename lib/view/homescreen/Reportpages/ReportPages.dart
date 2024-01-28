import 'package:adminsite/controller/homescreen_controller/reportsController/ReportPages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportPages extends StatefulWidget {
  @override
  _ReportPagesState createState() => _ReportPagesState();
}

class _ReportPagesState extends State<ReportPages> {
  ReportPagesController pageController = Get.put(ReportPagesController());
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await pageController.goTopageReport();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Data is still loading, display a loading indicator
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    int reportPagesCount = pageController.reportPagesData.length;

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
                rows: pageController.reportPagesData
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
