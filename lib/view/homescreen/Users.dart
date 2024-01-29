import 'package:adminsite/view/homescreen/UserTables/Connections.dart';
import 'package:adminsite/view/homescreen/UserTables/EducationLevel.dart';
import 'package:adminsite/view/homescreen/UserTables/SentConnections.dart';
import 'package:adminsite/view/homescreen/UserTables/UserApplications.dart';
import 'package:adminsite/view/homescreen/UserTables/UserPost.dart';
import 'package:adminsite/view/homescreen/UserTables/WorkExp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:adminsite/controller/homescreen_controller/Users_controller.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  UsersController userController = Get.put(UsersController());
  bool isLoading = true;
  int usersToShow = 10;

  TextEditingController firstNameFilterController = TextEditingController();
  TextEditingController lastNameFilterController = TextEditingController();
  TextEditingController usernameFilterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await userController.goUser();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Users: ${userController.userData.length}',
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
                    percent: userController.userData.length / 1000.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    reverse: false,
                    center: Text('${userController.userData.length}'),
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
                              Text('First Name'),
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
                              Text('Last Name'),
                              SizedBox(width: 10),
                              Container(
                                width: 150,
                                child: TextField(
                                  controller: lastNameFilterController,
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
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Bio')),
                        DataColumn(label: Text('Country')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Phone')),
                        DataColumn(label: Text('Date of Birth')),
                        DataColumn(label: Text('Gender')),
                        DataColumn(label: Text('Fields')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Created At')),
                        DataColumn(label: Text('Updated At')),
                        // Buttons for actions
                        DataColumn(label: Text('Connections')),
                        DataColumn(label: Text('Sent Connections')),
                        DataColumn(label: Text('Education Level')),
                        DataColumn(label: Text('Work Experience')),
                        DataColumn(label: Text('User Applications')),
                        DataColumn(label: Text('Update')),
                        DataColumn(label: Text('Delete')),
                        DataColumn(label: Text('Posts')),
                      ],
                      rows: userController.userData
                          .where((user) =>
                              user['firstname']!.toLowerCase().contains(firstNameFilterController.text.toLowerCase()) &&
                              user['lastname']!.toLowerCase().contains(lastNameFilterController.text.toLowerCase()) &&
                              user['username']!.toLowerCase().contains(usernameFilterController.text.toLowerCase()))
                          .take(usersToShow)
                          .map(
                            (user) => DataRow(
                              cells: [
                                DataCell(Text(user['firstname'] ?? '')),
                                DataCell(Text(user['lastname'] ?? '')),
                                DataCell(Text(user['username'] ?? '')),
                                DataCell(Text(user['email'] ?? '')),
                                DataCell(Text(user['bio'] ?? '')),
                                DataCell(Text(user['country'] ?? '')),
                                DataCell(Text(user['address'] ?? '')),
                                DataCell(Text(user['phone'] ?? '')),
                                DataCell(Text(user['dateOfBirth'] ?? '')),
                                DataCell(Text(user['gender'] ?? '')),
                                DataCell(Text(user['fields'] ?? '')),
                                DataCell(Text(user['status'] ?? '')),
                                DataCell(Text(user['type'] ?? '')),
                                DataCell(Text(user['createdAt'] ?? '')),
                                DataCell(Text(user['updatedAt'] ?? '')),
                                // Buttons for actions
                                DataCell(buildActionButton('Connections', user['username'] ?? '')),
                                DataCell(buildActionButton('Sent Connections', user['username'] ?? '')),
                                DataCell(buildActionButton('Education Level', user['username'] ?? '')),
                                DataCell(buildActionButton('Work Experience', user['username'] ?? '')),
                                DataCell(buildActionButton('User Applications', user['username'] ?? '')),
                                DataCell(buildActionButton('Update', user['username'] ?? '')),
                                DataCell(buildActionButton('Delete', user['username'] ?? '')),
                                DataCell(buildActionButton('Posts', user['username'] ?? '')),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  if (usersToShow < userController.userData.length)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          usersToShow += 10; // Increase the number of users to show
                        });
                      },
                      child: Text('Load More'),
                    ),
                ],
              ),
            ),
    );
  }

 Widget buildActionButton(String action, String username) {
  return ElevatedButton(
    onPressed: () {
      // Perform action based on the button clicked with the specific username
      switch (action) {
        case 'Connections':
          Get.to(Connections(username: username,));
          print('Clicked $action for username: $username');
          // Add your logic for 'Connections' action
          break;
        case 'Sent Connections':
          Get.to(SentConnections(username: username,));
          print('Clicked $action for username: $username');
          // Add your logic for 'Sent Connections' action
          break;
        case 'Education Level':
          Get.to(EducationalLevel(username: username,));
          print('Clicked $action for username: $username');
          // Add your logic for 'Education Level' action
          break;
        case 'Work Experience':
          Get.to(WorkExp(username: username,));
          print('Clicked $action for username: $username');
          // Add your logic for 'Work Experience' action
          break;
        case 'User Applications':
          Get.to(UserApplications(username: username,));
          print('Clicked $action for username: $username');
          // Add your logic for 'User Applications' action
          break;
        case 'Update':
          // Handle 'Update' action
          print('Clicked $action for username: $username');
          // Add your logic for 'Update' action
          break;
        case 'Delete':
          // Handle 'Delete' action
          print('Clicked $action for username: $username');
          // Add your logic for 'Delete' action
          break;
        case 'Posts':
          Get.to(UserPostsContent(username: username,));
          print('Clicked $action for username: $username');
          // Add your logic for 'Posts' action
          break;
        default:
          // Handle default case if needed
          break;
      }
    },
    child: Text(action),
  );
}

}
