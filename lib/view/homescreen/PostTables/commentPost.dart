import 'package:adminsite/controller/homescreen_controller/posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class CommentPost extends StatefulWidget {
   final String postId;

  CommentPost({required this.postId});
  @override
  _CommentPostState createState() => _CommentPostState();
}

class _CommentPostState extends State<CommentPost> {
  PostsController postController = Get.put(PostsController());
 
  int displayedComments = 10; // Number of comments initially displayed
  bool isLoading = true;
  TextEditingController idFilterController = TextEditingController();
  TextEditingController postIdFilterController = TextEditingController();
  TextEditingController contentFilterController = TextEditingController();
  TextEditingController dateFilterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await postController.goToComment(widget.postId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Comments"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Comments: ${postController.commentsData.length}',
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
                        postController.commentsData.length),
                    circularStrokeCap: CircularStrokeCap.round,
                    reverse: false,
                    center: Text('${postController.commentsData.length}'),
                    progressColor: Colors.green,
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Row(
                            children: [
                              Text('ID'),
                              SizedBox(width: 10),
                              Container(
                                width: 100,
                                child: TextField(
                                  controller: idFilterController,
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
                              Text('Post ID'),
                              SizedBox(width: 10),
                              Container(
                                width: 100,
                                child: TextField(
                                  controller: postIdFilterController,
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
                              Text('Content'),
                              SizedBox(width: 10),
                              Container(
                                width: 100,
                                child: TextField(
                                  controller: contentFilterController,
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
                              Text('Date'),
                              SizedBox(width: 10),
                              Container(
                                width: 100,
                                child: TextField(
                                  controller: dateFilterController,
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
                        rows: postController.commentsData
                            .where((comment) =>
                                comment['id']!.toLowerCase().contains(idFilterController.text.toLowerCase()) &&
                                comment['postId']!.toLowerCase().contains(postIdFilterController.text.toLowerCase()) &&
                                comment['content']!.toLowerCase().contains(contentFilterController.text.toLowerCase()) &&
                                comment['date']!.toLowerCase().contains(dateFilterController.text.toLowerCase()))
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
