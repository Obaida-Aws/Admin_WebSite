import 'package:adminsite/controller/homescreen_controller/Groups_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  List<Map<String, String>> groupsData = [
    {
      'id': '1',
      'groupId': 'G101',
      'username': 'User1',
      'createdAt': '2022-01-01',
    },
    {
      'id': '2',
      'groupId': 'G102',
      'username': 'User2',
      'createdAt': '2022-01-02',
    },
    // Add more sample data as needed
  ];

     GroupsController groupController = Get.put(GroupsController());

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupController.goToGroups();
  }

  @override
  Widget build(BuildContext context) {
    int groupsCount = groupsData.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Groups: $groupsCount',
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
              percent: calculatePercentage(groupsCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$groupsCount'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Group ID')),
                  DataColumn(label: Text('Username')),
                  DataColumn(label: Text('Created At')),
                ],
                rows: groupsData
                    .map(
                      (group) => DataRow(
                        cells: [
                          DataCell(Text(group['id'] ?? '')),
                          DataCell(Text(group['groupId'] ?? '')),
                          DataCell(Text(group['username'] ?? '')),
                          DataCell(Text(group['createdAt'] ?? '')),
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
