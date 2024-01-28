import 'package:adminsite/controller/homescreen_controller/tempUser_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TempUser extends StatefulWidget {
  @override
  _TempUserState createState() => _TempUserState();
}

class _TempUserState extends State<TempUser> {
  List<Map<String, String>> tempUserData = [
    {
      'username': 'user1',
      'firstname': 'John',
      'lastname': 'Doe',
      'email': 'john.doe@example.com',
      'phone': '123-456-7890',
      'dateOfBirth': '1990-01-01',
    },
    {
      'username': 'user2',
      'firstname': 'Jane',
      'lastname': 'Doe',
      'email': 'jane.doe@example.com',
      'phone': '987-654-3210',
      'dateOfBirth': '1995-02-15',
    },
    // Add more sample data as needed
  ];

    TempUserController tUserController = Get.put(TempUserController());

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tUserController.goToTempUser();
  }

  @override
  Widget build(BuildContext context) {
    int tempUserCount = tempUserData.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Temp Users: $tempUserCount',
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
                  DataColumn(label: Text('Username')),
                  DataColumn(label: Text('First Name')),
                  DataColumn(label: Text('Last Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Date of Birth')),
                  DataColumn(label: Text('Delete')),
                ],
                rows: tempUserData
                    .map(
                      (user) => DataRow(
                        cells: [
                          DataCell(Text(user['username'] ?? '')),
                          DataCell(Text(user['firstname'] ?? '')),
                          DataCell(Text(user['lastname'] ?? '')),
                          DataCell(Text(user['email'] ?? '')),
                          DataCell(Text(user['phone'] ?? '')),
                          DataCell(Text(user['dateOfBirth'] ?? '')),
                           DataCell(buildActionButton('Delete', user['username'] ?? '')),
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
