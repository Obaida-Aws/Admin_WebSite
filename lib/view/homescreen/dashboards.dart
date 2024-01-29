import 'package:adminsite/controller/homescreen_controller/homescreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardContent extends StatefulWidget {
  @override
  _DashboardContentState createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  HomeScreenController controller = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await controller.goToDashboard();
    setState(() {}); // Trigger a rebuild to update the UI
  }

  @override
  Widget build(BuildContext context) {
    if (controller.dashboardData.isEmpty) {
      // Display a loading indicator while data is being loaded
      return Center(child: CircularProgressIndicator());
    }

    int maxValue = controller.dashboardData.values.reduce((value, element) => value > element ? value : element);

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              for (var entry in controller.dashboardData.entries)
                CounterCard(entry.key, entry.value, maxValue),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterCard extends StatelessWidget {
  final String title;
  final int value;
  final int maxValue;

  CounterCard(this.title, this.value, this.maxValue);

  @override
  Widget build(BuildContext context) {
    double percentageUser=1000;
    double percentageavtiveUsers=50;
    double percentagePages=50;
    double percentageJobs=200;
    double percentagejobsApplications=1000;
    double percentageGroups=200;
    double percentagegroupMeeting=50;
    double percentagemessages=2000;
    double percentagePost=1000;
   

    double percentage = value / maxValue;
    percentage = percentage.clamp(0.0, 1.0);

    return SizedBox(
      width: 300,
      height: 250,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF111D4A), Color(0xFF111D4A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  radius: 120,
                  lineWidth: 20,
                  percent: percentage,
                  circularStrokeCap: CircularStrokeCap.round,
                  reverse: false,
                  center: AnimatedCountText(value: value),
                  progressColor: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedCountText extends StatelessWidget {
  final int value;

  AnimatedCountText({required this.value});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 1000),
      tween: IntTween(begin: 0, end: value),
      builder: (context, int count, child) {
        return Text(
          '$count',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
