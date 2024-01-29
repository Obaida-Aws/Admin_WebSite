import 'package:adminsite/controller/homescreen_controller/pages_controller.dart';
import 'package:adminsite/controller/homescreen_controller/tempUser_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PageFollowers extends StatefulWidget {
  final String pageId;

  PageFollowers({required this.pageId});
  @override
  _PageFollowersState createState() => _PageFollowersState();
}

class _PageFollowersState extends State<PageFollowers> {
  PagesController pageController = Get.put(PagesController());
  TextEditingController usernameFilterController = TextEditingController();
  TextEditingController firstNameFilterController = TextEditingController();
  TextEditingController lastNameFilterController = TextEditingController();
  TextEditingController emailFilterController = TextEditingController();
  TextEditingController phoneFilterController = TextEditingController();
  TextEditingController dobFilterController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await pageController.goToFollowersUsers(widget.pageId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int tempUserCount = pageController.followerUserData.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Page Follower"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' $tempUserCount',
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
                    percent: calculatePercentage(tempUserCount),
                    circularStrokeCap: CircularStrokeCap.round,
                    reverse: false,
                    center: Text('$tempUserCount'),
                    progressColor: Colors.green,
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Row(
                            children: [
                              Text('Username'),
                              SizedBox(width: 10),
                              Container(
                                width: 150,
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
                          ),
                        ),
                        DataColumn(
                          label: Row(
                            children: [
                              Text('Page Id'),
                              SizedBox(width: 10),
                              Container(
                                width: 150,
                                child: TextField(
                                  controller: firstNameFilterController,
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
                              Text('created At'),
                              SizedBox(width: 10),
                              Container(
                                width: 150,
                                child: TextField(
                                  controller: emailFilterController,
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
                              Text('updated At'),
                              SizedBox(width: 10),
                              Container(
                                width: 150,
                                child: TextField(
                                  controller: phoneFilterController,
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
                      rows: pageController.followerUserData
                          .where(
  (user) =>
      user['username']!
          .toLowerCase()
          .contains(usernameFilterController.text.toLowerCase()) &&
      user['pageId']!
          .toLowerCase()
          .contains(firstNameFilterController.text.toLowerCase()) &&
      user['createdAt']!
          .toLowerCase()
          .contains(emailFilterController.text.toLowerCase()) &&
      user['updatedAt']!
          .toLowerCase()
          .contains(phoneFilterController.text.toLowerCase()) 
   
)

                          .map(
                            (user) => DataRow(
                              cells: [
                                DataCell(Text(user['username'] ?? '')),
                                DataCell(Text(user['pageId'] ?? '')),
                                DataCell(Text(user['createdAt'] ?? '')),
                                DataCell(Text(user['updatedAt'] ?? '')),
                               
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

  Widget buildActionButton(String action, String username) {
    return ElevatedButton(
      onPressed: () {
        // Perform action based on the button clicked with the specific username
        print('Clicked $action for username: $username');
      },
      child: Text(action),
    );
  }
}
