import 'package:adminsite/controller/homescreen_controller/Groups_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  GroupsController groupController = Get.put(GroupsController());
  TextEditingController pageIdFilterController = TextEditingController();
  TextEditingController groupIdFilterController = TextEditingController();
  TextEditingController usernameFilterController = TextEditingController();
  TextEditingController createdAtFilterController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print("ffffffff");
    print(groupController.groupsData);
    loadData();
     print("ffffffffsssss");
  }

  Future<void> loadData() async {
    await groupController.goToGroups();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading indicator while the data is being fetched
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    int groupsCount = groupController.groupsData.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            CircularPercentIndicator(
              animation: true,
              animationDuration: 1000,
              radius: 120,
              lineWidth: 20,
              percent: calculatePercentage(groupsCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$groupsCount'),
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
                        Text('pageId'),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          child: TextField(
                            controller: pageIdFilterController,
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
                        Text('Group ID'),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          child: TextField(
                            controller: groupIdFilterController,
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
                        Text('Name'),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
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
                        Text('Created At'),
                        SizedBox(width: 10),
                        Container(
                          width: 150,
                          child: TextField(
                            controller: createdAtFilterController,
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
                rows: groupController.groupsData
                    .where(
                      (group) =>
                          group['pageId']!.toLowerCase().contains(pageIdFilterController.text.toLowerCase()) &&
                          group['groupId']!.toLowerCase().contains(groupIdFilterController.text.toLowerCase()) &&
                          group['name']!.toLowerCase().contains(usernameFilterController.text.toLowerCase()) &&
                          group['createdAt']!.toLowerCase().contains(createdAtFilterController.text.toLowerCase()),
                    )
                    .map(
                      (group) => DataRow(
                        cells: [
                          DataCell(Text(group['pageId'] ?? '')),
                          DataCell(Text(group['groupId'] ?? '')),
                          DataCell(Text(group['name'] ?? '')),
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
