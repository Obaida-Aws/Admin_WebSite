import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:adminsite/controller/homescreen_controller/Comment_controller.dart';

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  CommentController commentController = Get.put(CommentController());
  int displayedComments = 10; // Number of comments initially displayed
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await commentController.goToComment();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Comments: ${commentController.commentsData.length}',
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
                    percent: calculatePercentage(
                        commentController.commentsData.length),
                    circularStrokeCap: CircularStrokeCap.round,
                    reverse: false,
                    center: Text('${commentController.commentsData.length}'),
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
                      rows: commentController.commentsData
                          .take(displayedComments)
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
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: loadMoreComments,
                    child: Text('Load More Comments'),
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

  void loadMoreComments() {
    setState(() {
      displayedComments += 10; // Increase the number of displayed comments
    });
  }
}
