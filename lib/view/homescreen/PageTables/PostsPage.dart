import 'package:adminsite/controller/homescreen_controller/pages_controller.dart';
import 'package:adminsite/controller/homescreen_controller/posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PagePostsContent extends StatefulWidget {
  final String pageId;

  PagePostsContent({required this.pageId});
  @override
  _PagePostsContentState createState() => _PagePostsContentState();
}

class _PagePostsContentState extends State<PagePostsContent> {

   PagesController pageController = Get.put(PagesController());
  bool isLoading = true;
  int postsToShow = 10;
  int postsPerPage = 10;
  TextEditingController createdByFilterController = TextEditingController();
  TextEditingController postContentFilterController = TextEditingController();
  TextEditingController privacyFilterController = TextEditingController();
  TextEditingController postDateFilterController = TextEditingController();
  TextEditingController commentCountFilterController = TextEditingController();
  TextEditingController likeCountFilterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await pageController.goToPosts(widget.pageId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    int postsLength = pageController.postsData.length;
    double percentage = postsLength / 100.0;
    percentage = percentage.clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: Text("Page Posts"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Posts: $postsLength',
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
              percent: percentage,
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$postsLength'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Post ID')),
                  DataColumn(
                    label: Row(
                      children: [
                        Text('Created By'),
                        SizedBox(width: 10),
                        Container(
                          width: 150,
                          child: TextField(
                            controller: createdByFilterController,
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
                    ),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Text('Post Content'),
                        SizedBox(width: 10),
                        Container(
                          width: 150,
                          child: TextField(
                            controller: postContentFilterController,
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
                    ),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Text('Privacy'),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          child: TextField(
                            controller: privacyFilterController,
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
                    ),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Text('Post Date'),
                        SizedBox(width: 10),
                        Container(
                          width: 150,
                          child: TextField(
                            controller: postDateFilterController,
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
                    ),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Text('Comment Count'),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          child: TextField(
                            controller: commentCountFilterController,
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
                    ),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Text('Like Count'),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          child: TextField(
                            controller: likeCountFilterController,
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
                    ),
                  ),
                  DataColumn(label: Text('Comments')),
                  DataColumn(label: Text('Likes')),
                ],
                rows: pageController.postsData
                    .where(
                      (post) =>
                          post['createdBy'].toLowerCase().contains(createdByFilterController.text.toLowerCase()) &&
                          post['postContent'].toLowerCase().contains(postContentFilterController.text.toLowerCase()) &&
                          post['selectedPrivacy'].toLowerCase().contains(privacyFilterController.text.toLowerCase()) &&
                          post['postDate'].toLowerCase().contains(postDateFilterController.text.toLowerCase()) &&
                          post['commentCount'].toString().toLowerCase().contains(commentCountFilterController.text.toLowerCase()) &&
                          post['likeCount'].toString().toLowerCase().contains(likeCountFilterController.text.toLowerCase()),
                    )
                    .take(postsToShow)
                    .map(
                      (post) => DataRow(
                        cells: [
                          DataCell(Text(post['postId'].toString())),
                          DataCell(Text(post['createdBy'])),
                          DataCell(Text(post['postContent'])),
                          DataCell(Text(post['selectedPrivacy'])),
                          DataCell(Text(post['postDate'])),
                          DataCell(Text(post['commentCount'].toString())),
                          DataCell(Text(post['likeCount'].toString())),
                          DataCell(buildActionButton('Comments', post['postId'])),
                          DataCell(buildActionButton('Likes', post['postId'])),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            if (postsToShow < postsLength)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    postsToShow += postsPerPage;
                  });
                },
                child: Text('Load More'),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildActionButton(String action, String postId) {
    return ElevatedButton(
      onPressed: () {
        print('Clicked $action for postId: $postId');
      },
      child: Text(action),
    );
  }
}
