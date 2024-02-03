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
  TextEditingController reportIdFilterController = TextEditingController();
  TextEditingController pageNameFilterController = TextEditingController();
  TextEditingController reasonFilterController = TextEditingController();
  TextEditingController usernameFilterController = TextEditingController();
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
            CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 120,
              lineWidth: 20,
              percent: calculatePercentage(reportPagesCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$reportPagesCount'),
              progressColor: Color.fromARGB(255, 57, 188, 221),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Row(
                    children: [
                      Text('Username'),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: usernameFilterController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: 'Filter',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  )),
                  DataColumn(label: Row(
                    children: [
                      Text('Report ID'),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: reportIdFilterController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: 'Filter',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  )),
                  DataColumn(label: Row(
                    children: [
                      Text('Page Name'),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: pageNameFilterController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: 'Filter',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  )),
                  DataColumn(label: Row(
                    children: [
                      Text('Reason'),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: reasonFilterController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: 'Filter',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
                rows: pageController.reportPagesData
                    .where((page) =>
                        page['username']!.toLowerCase().contains(usernameFilterController.text.toLowerCase()) &&
                        page['reportId']!.toLowerCase().contains(reportIdFilterController.text.toLowerCase()) &&
                        page['pageName']!.toLowerCase().contains(pageNameFilterController.text.toLowerCase()) &&
                        page['reason']!.toLowerCase().contains(reasonFilterController.text.toLowerCase()))
                    .map(
                      (page) => DataRow(
                        cells: [
                          DataCell(Text(page['username'] ?? '')),
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
