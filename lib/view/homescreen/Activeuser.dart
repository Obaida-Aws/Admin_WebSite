import 'package:adminsite/controller/homescreen_controller/activeUser_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ActiveUsers extends StatefulWidget {
  @override
  _ActiveUsersState createState() => _ActiveUsersState();
}

class _ActiveUsersState extends State<ActiveUsers> {
  ActiveUserController AUserController = Get.put(ActiveUserController());
  TextEditingController idFilterController = TextEditingController();
  TextEditingController usernameFilterController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await AUserController.goToActiveUser();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int activeUsersCount = AUserController.activeUsersData.length;

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
              percent: calculatePercentage(activeUsersCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$activeUsersCount'),
              progressColor: Color.fromARGB(255, 57, 188, 221),
            ),
            SizedBox(height: 16),
            isLoading
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Row(
                            children: [
                              Text('ID'),
                              SizedBox(width: 10),
                              Container(
                                width: 150,
                                child: TextField(
                                  controller: idFilterController,
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
                      ],
                      rows: AUserController.activeUsersData
                          .where(
                            (user) =>
                                user['id']!.toLowerCase().contains(idFilterController.text.toLowerCase()) &&
                                user['username']!.toLowerCase().contains(usernameFilterController.text.toLowerCase()),
                          )
                          .map(
                            (user) => DataRow(
                              cells: [
                                DataCell(Text(user['id'] ?? '')),
                                DataCell(Text(user['username'] ?? '')),
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
