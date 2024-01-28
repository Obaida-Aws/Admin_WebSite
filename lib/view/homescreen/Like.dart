import 'package:adminsite/controller/homescreen_controller/Like_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Like extends StatefulWidget {
  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  LikeController likeController = Get.put(LikeController());
  bool isLoading = true;
  int displayedItems = 10; // Number of items to display initially

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await likeController.goToLike();
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
    int likesCount = likeController.likesData.length;

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
            isLoading
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Post ID')),
                        DataColumn(label: Text('Username')),
                        DataColumn(label: Text('Page ID')),
                        DataColumn(label: Text('Created At')),
                      ],
                      rows: likeController.likesData
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
