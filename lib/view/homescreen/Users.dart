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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: userController.goUser(), // Replace with your actual data fetching function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data'),
            );
          } else {
            int userListLength = userController.userData.length;
            double percentage = userListLength / 1000.0;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Users: $userListLength',
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
                    center: Text('$userListLength'),
                    progressColor: Colors.green,
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('First Name')),
                        DataColumn(label: Text('Last Name')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Bio')),
                        DataColumn(label: Text('Country')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Phone')),
                        DataColumn(label: Text('Date of Birth')),
                        DataColumn(label: Text('Gender')),
                        DataColumn(label: Text('Fields')),
                        DataColumn(label: Text('Username')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Created At')),
                        DataColumn(label: Text('Updated At')),
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
                          .map(
                            (user) => DataRow(
                              cells: [
                                DataCell(Text(user['firstname'] ?? '')),
                                DataCell(Text(user['lastname'] ?? '')),
                                DataCell(Text(user['email'] ?? '')),
                                DataCell(Text(user['bio'] ?? '')),
                                DataCell(Text(user['country'] ?? '')),
                                DataCell(Text(user['address'] ?? '')),
                                DataCell(Text(user['phone'] ?? '')),
                                DataCell(Text(user['dateOfBirth'] ?? '')),
                                DataCell(Text(user['gender'] ?? '')),
                                DataCell(Text(user['fields'] ?? '')),
                                DataCell(Text(user['username'] ?? '')),
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
                ],
              ),
            );
          }
        },
      ),
    );
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