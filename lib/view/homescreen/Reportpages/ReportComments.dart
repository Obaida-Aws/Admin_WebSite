import 'package:adminsite/controller/homescreen_controller/reportsController/CommentReport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportComments extends StatefulWidget {
  @override
  _ReportCommentsState createState() => _ReportCommentsState();
}

class _ReportCommentsState extends State<ReportComments> {
  List<Map<String, String>> repostCommentsData = [
    {
      'reportId': '1',
      'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'createdBy': 'User1',
      'commentId': '101',
    },
    {
      'reportId': '2',
      'content': 'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'createdBy': 'User2',
      'commentId': '102',
    },
    // Add more sample data as needed
  ];
   ReportCommentController commentController = Get.put(ReportCommentController());

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentController.goToCommentReport();
  }

  @override
  Widget build(BuildContext context) {
    int repostCommentsCount = repostCommentsData.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Repost Comments: $repostCommentsCount',
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
              percent: calculatePercentage(repostCommentsCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$repostCommentsCount'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Report ID')),
                  DataColumn(label: Text('Content')),
                  DataColumn(label: Text('Created By')),
                  DataColumn(label: Text('Comment ID')),
                ],
                rows: repostCommentsData
                    .map(
                      (comment) => DataRow(
                        cells: [
                          DataCell(Text(comment['reportId'] ?? '')),
                          DataCell(Text(comment['content'] ?? '')),
                          DataCell(Text(comment['createdBy'] ?? '')),
                          DataCell(Text(comment['commentId'] ?? '')),
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
