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
            Text(
              'Active Users: $activeUsersCount',
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
              percent: calculatePercentage(activeUsersCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$activeUsersCount'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            isLoading
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Username')),
                      ],
                      rows: AUserController.activeUsersData
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
