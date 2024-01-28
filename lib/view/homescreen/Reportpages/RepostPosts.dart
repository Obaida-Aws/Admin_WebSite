import 'package:adminsite/controller/homescreen_controller/reportsController/ReportPost_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportPosts extends StatefulWidget {
  @override
  _ReportPostsState createState() => _ReportPostsState();
}

class _ReportPostsState extends State<ReportPosts> {
  List<Map<String, String>> reportPostsData = [
    {
      'reportId': '1',
      'title': 'Post Title 1',
      'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'createdBy': 'User1',
      'postId': '201',
    },
    {
      'reportId': '2',
      'title': 'Post Title 2',
      'content': 'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'createdBy': 'User2',
      'postId': '202',
    },
    // Add more sample data as needed
  ];
     ReportPostsController postController = Get.put(ReportPostsController());

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postController.goTopostReport();
  }

  @override
  Widget build(BuildContext context) {
    int reportPostsCount = reportPostsData.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Report Posts: $reportPostsCount',
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
              percent: calculatePercentage(reportPostsCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$reportPostsCount'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Report ID')),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Content')),
                  DataColumn(label: Text('Created By')),
                  DataColumn(label: Text('Post ID')),
                ],
                rows: reportPostsData
                    .map(
                      (post) => DataRow(
                        cells: [
                          DataCell(Text(post['reportId'] ?? '')),
                          DataCell(Text(post['title'] ?? '')),
                          DataCell(Text(post['content'] ?? '')),
                          DataCell(Text(post['createdBy'] ?? '')),
                          DataCell(Text(post['postId'] ?? '')),
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
