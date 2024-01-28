import 'package:adminsite/controller/homescreen_controller/Like_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Like extends StatefulWidget {
  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  List<Map<String, String>> likesData = [
    {
      'id': '1',
      'postId': '101',
      'username': 'User1',
      'pageId': '201',
      'createdAt': '2022-01-01',
    },
    {
      'id': '2',
      'postId': '102',
      'username': 'User2',
      'pageId': '202',
      'createdAt': '2022-01-02',
    },
    // Add more sample data as needed
  ];

    LikeController likeController = Get.put(LikeController());

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    likeController.goToLike();
  }

  @override
  Widget build(BuildContext context) {
    int likesCount = likesData.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Likes: $likesCount',
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
              percent: calculatePercentage(likesCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$likesCount'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Post ID')),
                  DataColumn(label: Text('Username')),
                  DataColumn(label: Text('Page ID')),
                  DataColumn(label: Text('Created At')),
                ],
                rows: likesData
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
