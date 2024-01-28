import 'package:adminsite/controller/homescreen_controller/posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PostsContent extends StatefulWidget {
  @override
  _PostsContentState createState() => _PostsContentState();
}

class _PostsContentState extends State<PostsContent> {
  PostsController postController = Get.put(PostsController());
  bool isLoading = true;
  int postsToShow = 10; // Number of posts to initially show
  int postsPerPage = 10; // Number of posts to load per page

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await postController.goPosts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading indicator while the data is being fetched
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    int postsLength = postController.postsData.length;
    double percentage = postsLength / 100.0;
    percentage = percentage.clamp(0.0, 1.0);

    return Scaffold(
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
                  DataColumn(label: Text('Created By')),
                  DataColumn(label: Text('Post Content')),
                  DataColumn(label: Text('Privacy')),
                  DataColumn(label: Text('Post Date')),
                  DataColumn(label: Text('Comment Count')),
                  DataColumn(label: Text('Like Count')),
                  DataColumn(label: Text('Comments')),
                  DataColumn(label: Text('Likes')),
                ],
                rows: postController.postsData
                    .take(postsToShow) // Display only a subset of posts
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
                          // Buttons for actions
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
        // Perform action based on the button clicked with the specific postId
        print('Clicked $action for postId: $postId');
      },
      child: Text(action),
    );
  }
}
