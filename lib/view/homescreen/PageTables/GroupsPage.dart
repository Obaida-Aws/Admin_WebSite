import 'package:adminsite/controller/homescreen_controller/Groups_controller.dart';
import 'package:adminsite/controller/homescreen_controller/pages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PageGroups extends StatefulWidget {
  final String pageId;

  PageGroups({required this.pageId});
  @override
  _PageGroupsState createState() => _PageGroupsState();
}

class _PageGroupsState extends State<PageGroups> {
 
  PagesController pageController = Get.put(PagesController());
  TextEditingController pageIdFilterController = TextEditingController();
  TextEditingController groupIdFilterController = TextEditingController();
  TextEditingController usernameFilterController = TextEditingController();
  TextEditingController createdAtFilterController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await pageController.goToGroups(widget.pageId);
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

    int groupsCount = pageController.groupsData.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Page Groups"),
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
                        Text('Username'),
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
                rows: pageController.groupsData
                    .where(
                      (group) =>
                          group['pageId']!.toLowerCase().contains(pageIdFilterController.text.toLowerCase()) &&
                          group['groupId']!.toLowerCase().contains(groupIdFilterController.text.toLowerCase()) &&
                          group['username']!.toLowerCase().contains(usernameFilterController.text.toLowerCase()) &&
                          group['createdAt']!.toLowerCase().contains(createdAtFilterController.text.toLowerCase()),
                    )
                    .map(
                      (group) => DataRow(
                        cells: [
                          DataCell(Text(group['pageId'] ?? '')),
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
