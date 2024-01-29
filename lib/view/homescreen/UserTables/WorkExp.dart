import 'package:adminsite/controller/homescreen_controller/Users_controller.dart';
import 'package:adminsite/controller/homescreen_controller/posts_controller.dart';
import 'package:adminsite/view/homescreen/PostTables/commentPost.dart';
import 'package:adminsite/view/homescreen/PostTables/likePost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WorkExp extends StatefulWidget {
    final String username;

  WorkExp({required this.username});
  @override
  _WorkExpState createState() => _WorkExpState();
}

class _WorkExpState extends State<WorkExp> {
   UsersController userController = Get.put(UsersController());
  
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
    await userController.goToWork(widget.username);
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

    int postsLength = userController.workData.length;
    double percentage = postsLength / 100.0;
    percentage = percentage.clamp(0.0, 1.0);

    return Scaffold(
          appBar: AppBar(
        title: Text("Work Exp"),
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
              percent: percentage,
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$postsLength'),
              progressColor: Color.fromARGB(255, 57, 188, 221),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text(' ID')),
                  DataColumn(
                    label: Row(
                      children: [
                        Text('Username'),
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
                        Text('specialty'),
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
                        Text('Company'),
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
                        Text('description'),
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
                        Text('startDate'),
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
                        Text('endDate'),
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
                  
                 
    
                ],
                rows: userController.workData
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

}
