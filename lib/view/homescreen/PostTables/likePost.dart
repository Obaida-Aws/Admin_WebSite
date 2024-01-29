import 'package:adminsite/controller/homescreen_controller/posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:adminsite/controller/homescreen_controller/Like_controller.dart';

class PostLike extends StatefulWidget {

    final String postId;

  PostLike({required this.postId});
  @override
  _PostLikeState createState() => _PostLikeState();
}

class _PostLikeState extends State<PostLike> {
 
    PostsController postController = Get.put(PostsController());
  bool isLoading = true;
  int displayedItems = 10; // Number of items to display initially
  TextEditingController idFilterController = TextEditingController();
  TextEditingController postIdFilterController = TextEditingController();
  TextEditingController usernameFilterController = TextEditingController();
  TextEditingController pageIdFilterController = TextEditingController();
  TextEditingController createdAtFilterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await postController.goToLike(widget.postId);
    setState(() {
      isLoading = false;
    });
  }

  void loadMore() {
    setState(() {
      displayedItems += 10; // Increase the number of displayed items
    });
  }

  @override
  Widget build(BuildContext context) {
    int likesCount = postController.likesData.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Post Likes"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 120,
              lineWidth: 20,
              percent: calculatePercentage(likesCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$likesCount'),
              progressColor: Color.fromARGB(255, 57, 188, 221),
            ),
            SizedBox(height: 16),
            isLoading
                ? CircularProgressIndicator()
                : Center(
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
                              Text('Page ID'),
                              SizedBox(width: 10),
                              Container(
                                width: 100,
                                child: TextField(
                                  controller: pageIdFilterController,
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
                              Text('Created At'),
                              SizedBox(width: 10),
                              Container(
                                width: 100,
                                child: TextField(
                                  controller: createdAtFilterController,
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
                        rows: postController.likesData
                            .where((like) =>
                                like['id']!.toLowerCase().contains(idFilterController.text.toLowerCase()) &&
                                like['postId']!.toLowerCase().contains(postIdFilterController.text.toLowerCase()) &&
                                like['username']!.toLowerCase().contains(usernameFilterController.text.toLowerCase()) &&
                                like['pageId']!.toLowerCase().contains(pageIdFilterController.text.toLowerCase()) &&
                                like['createdAt']!.toLowerCase().contains(createdAtFilterController.text.toLowerCase()))
                            .take(displayedItems) // Display only the first N items
                            .map(
                              (like) => DataRow(
                                cells: [
                                  DataCell(Text(like['id'] ?? '')),
                                  DataCell(Text(like['postId'] ?? '')),
                                  DataCell(Text(like['username'] ?? '')),
                                  DataCell(Text(like['pageId'] ?? '')),
                                  DataCell(Text(like['createdAt'] ?? '')),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: loadMore,
              child: Text('Load More'),
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
