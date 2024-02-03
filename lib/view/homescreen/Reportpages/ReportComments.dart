import 'package:adminsite/controller/homescreen_controller/reportsController/CommentReport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportComments extends StatefulWidget {
  @override
  _ReportCommentsState createState() => _ReportCommentsState();
}

class _ReportCommentsState extends State<ReportComments> {
  ReportCommentController commentController = Get.put(ReportCommentController());
  TextEditingController reportIdFilterController = TextEditingController();
  TextEditingController contentFilterController = TextEditingController();
  TextEditingController createdByFilterController = TextEditingController();
  TextEditingController commentIdFilterController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await commentController.goToCommentReport();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  CircularPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    radius: 120,
                    lineWidth: 20,
                    percent: calculatePercentage(commentController.repostCommentsData.length),
                    circularStrokeCap: CircularStrokeCap.round,
                    reverse: false,
                    center: Text('${commentController.repostCommentsData.length}'),
                    progressColor: Color.fromARGB(255, 57, 188, 221),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Row(
                          children: [
                            Text('Report ID'),
                            SizedBox(width: 10),
                            Container(
                              width: 100,
                              child: TextField(
                                controller: reportIdFilterController,
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
                            Text('Username'),
                            SizedBox(width: 10),
                            Container(
                              width: 100,
                              child: TextField(
                                controller: createdByFilterController,
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
                            Text('Content'),
                            SizedBox(width: 10),
                            Container(
                              width: 100,
                              child: TextField(
                                controller: contentFilterController,
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
                            Text('Comment ID'),
                            SizedBox(width: 10),
                            Container(
                              width: 100,
                              child: TextField(
                                controller: commentIdFilterController,
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
                      rows: commentController.repostCommentsData
                          .where((comment) =>
                              comment['reportId']!.toLowerCase().contains(reportIdFilterController.text.toLowerCase()) &&
                              comment['content']!.toLowerCase().contains(contentFilterController.text.toLowerCase()) &&
                              comment['username']!.toLowerCase().contains(createdByFilterController.text.toLowerCase()) &&
                              comment['commentId']!.toLowerCase().contains(commentIdFilterController.text.toLowerCase()))
                          .map(
                            (comment) => DataRow(
                              cells: [
                                DataCell(Text(comment['reportId'] ?? '')),
                                DataCell(Text(comment['username'] ?? '')),
                                DataCell(Text(comment['content'] ?? '')),
                                DataCell(Text(comment['commentId'] ?? '')),
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
