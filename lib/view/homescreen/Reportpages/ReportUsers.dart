import 'package:adminsite/controller/homescreen_controller/reportsController/Reportuser_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportUsers extends StatefulWidget {
  @override
  _ReportUsersState createState() => _ReportUsersState();
}

class _ReportUsersState extends State<ReportUsers> {
  List<Map<String, String>> reportUsersData = [
    {
      'reportId': '1',
      'username': 'User1',
      'reason': 'Inappropriate Content',
    },
    {
      'reportId': '2',
      'username': 'User2',
      'reason': 'Harassment',
    },
    // Add more sample data as needed
  ];

     ReportUsersController userController = Get.put(ReportUsersController());

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.goTouserReport();
  }

  @override
  Widget build(BuildContext context) {
    int reportUsersCount = reportUsersData.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Report Users: $reportUsersCount',
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
              percent: calculatePercentage(reportUsersCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$reportUsersCount'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Report ID')),
                  DataColumn(label: Text('Username')),
                  DataColumn(label: Text('Reason')),
                ],
                rows: reportUsersData
                    .map(
                      (user) => DataRow(
                        cells: [
                          DataCell(Text(user['reportId'] ?? '')),
                          DataCell(Text(user['username'] ?? '')),
                          DataCell(Text(user['reason'] ?? '')),
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
