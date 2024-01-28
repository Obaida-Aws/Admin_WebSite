import 'package:adminsite/controller/homescreen_controller/reportsController/ReportPost_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportPosts extends StatefulWidget {
  @override
  _ReportPostsState createState() => _ReportPostsState();
}

class _ReportPostsState extends State<ReportPosts> {
  ReportPostsController postController = Get.put(ReportPostsController());
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await postController.goTopostReport();
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

    int reportPostsCount = postController.reportPostsData.length;

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
                rows: postController.reportPostsData
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
