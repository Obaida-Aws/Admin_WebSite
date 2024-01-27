import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PostsContent extends StatefulWidget {
  @override
  _PostsContentState createState() => _PostsContentState();
}

class _PostsContentState extends State<PostsContent> {
  List<Map<String, dynamic>> postsData = [
    {
      'postId': '1',
      'createdBy': 'John Doe',
      'postContent': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'selectedPrivacy': 'Public',
      'postDate': '2022-01-20',
      'commentCount': 5,
      'likeCount': 10,
    },
    {
      'postId': '2',
      'createdBy': 'Jane Doe',
      'postContent': 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'selectedPrivacy': 'Private',
      'postDate': '2022-01-22',
      'commentCount': 8,
      'likeCount': 15,
    },
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    int postsLength = postsData.length;
    double percentage = postsLength / 100.0; // Assuming the maximum length is 100

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
                rows: postsData
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
