import 'package:adminsite/controller/homescreen_controller/jobs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Jobs extends StatefulWidget {
  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  JobsController jobController = Get.put(JobsController());
  bool isLoading = true;
  TextEditingController jobIdFilterController = TextEditingController();
  TextEditingController pageIdFilterController = TextEditingController();
  TextEditingController titleFilterController = TextEditingController();
  TextEditingController fieldsFilterController = TextEditingController();
  TextEditingController descriptionFilterController = TextEditingController();
  TextEditingController endDateFilterController = TextEditingController();
  TextEditingController createdAtFilterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    jobController.goToJobs().then((_) {
      setState(() {
        isLoading = false;
      });
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

    int jobsCount = jobController.jobsData.length;

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
              percent: calculatePercentage(jobsCount),
              circularStrokeCap: CircularStrokeCap.round,
              reverse: false,
              center: Text('$jobsCount'),
              progressColor: Color.fromARGB(255, 57, 188, 221),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Row(
                    children: [
                      Text('Job ID'),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: jobIdFilterController,
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
                  )),
                  DataColumn(label: Row(
                    children: [
                      Text('Page ID'),
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
                  )),
                  DataColumn(label: Row(
                    children: [
                      Text('Title'),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: titleFilterController,
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
                  )),
                  DataColumn(label: Row(
                    children: [
                      Text('Fields'),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: fieldsFilterController,
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
                  )),
                  DataColumn(label: Row(
                    children: [
                      Text('Description'),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: descriptionFilterController,
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
                  )),
                  DataColumn(label: Row(
                    children: [
                      Text('End Date'),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: endDateFilterController,
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
                  )),
                  DataColumn(label: Row(
                    children: [
                      Text('Created At'),
                      SizedBox(width: 10),
                      Container(
                        width: 100,
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
                  )),
                ],
                rows: jobController.jobsData
                    .where((job) =>
                        job['jobId']!.toLowerCase().contains(jobIdFilterController.text.toLowerCase()) &&
                        job['pageId']!.toLowerCase().contains(pageIdFilterController.text.toLowerCase()) &&
                        job['title']!.toLowerCase().contains(titleFilterController.text.toLowerCase()) &&
                        job['fields']!.toLowerCase().contains(fieldsFilterController.text.toLowerCase()) &&
                        job['description']!.toLowerCase().contains(descriptionFilterController.text.toLowerCase()) &&
                        job['endDate']!.toLowerCase().contains(endDateFilterController.text.toLowerCase()) &&
                        job['createdAt']!.toLowerCase().contains(createdAtFilterController.text.toLowerCase()))
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
    double percentage = count / 500.0;
    if (percentage > 1.0) {
      percentage = 1.0;
    }
    return percentage;
  }
}
