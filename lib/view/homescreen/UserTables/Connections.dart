import 'package:adminsite/controller/homescreen_controller/Users_controller.dart';
import 'package:adminsite/controller/homescreen_controller/pages_controller.dart';
import 'package:adminsite/controller/homescreen_controller/tempUser_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Connections extends StatefulWidget {
  final String username;

  Connections({required this.username});
  @override
  _ConnectionsState createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
 
  UsersController userController = Get.put(UsersController());
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
    await userController.goToFollowersUsers(widget.username);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int tempUserCount = userController.followerUserData.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("User Connections"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  CircularPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    radius: 120,
                    lineWidth: 20,
                    percent: calculatePercentage(tempUserCount),
                    circularStrokeCap: CircularStrokeCap.round,
                    reverse: false,
                    center: Text('$tempUserCount'),
                    progressColor: Color.fromARGB(255, 57, 188, 221),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Row(
                            children: [
                              Text('receiverUsername'),
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
                              Text('senderUsername'),
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
                              Text('date'),
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
                       
                       
                       
                      ],
                      rows: userController.followerUserData
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
