import 'package:adminsite/controller/homescreen_controller/jobs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Jobs extends StatefulWidget {
  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  List<Map<String, String>> jobsData = [
    {
      'jobId': 'J101',
      'pageId': 'P101',
      'title': 'Job Title 1',
      'fields': 'Field1',
      'description': 'Lorem ipsum dolor sit amet.',
      'endDate': '2022-02-28',
      'createdAt': '2022-01-01',
    },
    {
      'jobId': 'J102',
      'pageId': 'P102',
      'title': 'Job Title 2',
      'fields': 'Field2',
      'description': 'Consectetur adipiscing elit.',
      'endDate': '2022-03-15',
      'createdAt': '2022-01-02',
    },
    // Add more sample data as needed
  ];

    JobsController jobController = Get.put(JobsController());

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobController.goToJobs();
  }

  @override
  Widget build(BuildContext context) {
    int jobsCount = jobsData.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Jobs: $jobsCount',
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
              percent: calculatePercentage(jobsCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$jobsCount'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Job ID')),
                  DataColumn(label: Text('Page ID')),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Fields')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('End Date')),
                  DataColumn(label: Text('Created At')),
                ],
                rows: jobsData
                    .map(
                      (job) => DataRow(
                        cells: [
                          DataCell(Text(job['jobId'] ?? '')),
                          DataCell(Text(job['pageId'] ?? '')),
                          DataCell(Text(job['title'] ?? '')),
                          DataCell(Text(job['fields'] ?? '')),
                          DataCell(Text(job['description'] ?? '')),
                          DataCell(Text(job['endDate'] ?? '')),
                          DataCell(Text(job['createdAt'] ?? '')),
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
