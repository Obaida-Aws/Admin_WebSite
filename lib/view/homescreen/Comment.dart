import 'package:adminsite/controller/homescreen_controller/Comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  

     CommentController commentController = Get.put(CommentController());

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentController.goToComment();
  }

  @override
  Widget build(BuildContext context) {
    int commentsCount =commentController. commentsData.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Comments: $commentsCount',
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
              percent: calculatePercentage(commentsCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$commentsCount'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Post ID')),
                  DataColumn(label: Text('Content')),
                  DataColumn(label: Text('Date')),
                ],
                rows:commentController. commentsData
                    .map(
                      (comment) => DataRow(
                        cells: [
                          DataCell(Text(comment['id'] ?? '')),
                          DataCell(Text(comment['postId'] ?? '')),
                          DataCell(Text(comment['content'] ?? '')),
                          DataCell(Text(comment['date'] ?? '')),
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
