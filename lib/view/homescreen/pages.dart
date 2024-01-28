import 'package:adminsite/controller/homescreen_controller/pages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  PagesController pageController = Get.put(PagesController());
  TextEditingController idFilterController = TextEditingController();
  TextEditingController nameFilterController = TextEditingController();
  TextEditingController descriptionFilterController = TextEditingController();
  TextEditingController countryFilterController = TextEditingController();
  TextEditingController addressFilterController = TextEditingController();
  TextEditingController contactInfoFilterController = TextEditingController();
  TextEditingController specialtyFilterController = TextEditingController();
  TextEditingController pageTypeFilterController = TextEditingController();
  TextEditingController createdAtFilterController = TextEditingController();
  TextEditingController updatedAtFilterController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await pageController.goToPages();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int pagesLength = pageController.pagesData.length;
    double percentage = pagesLength / 50.0;

    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pages: $pagesLength',
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
                    percent: percentage,
                    circularStrokeCap: CircularStrokeCap.round,
                    reverse: false,
                    center: Text('$pagesLength'),
                    progressColor: Colors.green,
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Row(
                            children: [
                              Text('ID'),
                              SizedBox(width: 30),
                              Container(
                                width: 200,
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
                              Text('Name'),
                              SizedBox(width: 30),
                              Container(
                                width: 200,
                                child: TextField(
                                  controller: nameFilterController,
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
                              Text('Description'),
                              SizedBox(width: 30),
                              Container(
                                width: 200,
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
                          ),
                        ),
                        DataColumn(
                          label: Row(
                            children: [
                              Text('Country'),
                              SizedBox(width: 30),
                              Container(
                                width: 150,
                                child: TextField(
                                  controller: countryFilterController,
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
                              Text('Address'),
                              SizedBox(width: 30),
                              Container(
                                width: 200,
                                child: TextField(
                                  controller: addressFilterController,
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
                              Text('Contact Info'),
                              SizedBox(width: 30),
                              Container(
                                width: 200,
                                child: TextField(
                                  controller: contactInfoFilterController,
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
                              Text('Specialty'),
                              SizedBox(width: 30),
                              Container(
                                width: 150,
                                child: TextField(
                                  controller: specialtyFilterController,
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
                              Text('Page Type'),
                              SizedBox(width: 30),
                              Container(
                                width: 150,
                                child: TextField(
                                  controller: pageTypeFilterController,
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
                              SizedBox(width: 30),
                              Container(
                                width: 200,
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
                        DataColumn(
                          label: Row(
                            children: [
                              Text('Updated At'),
                              SizedBox(width: 30),
                              Container(
                                width: 200,
                                child: TextField(
                                  controller: updatedAtFilterController,
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
                        DataColumn(label: Text('Page')),
                        DataColumn(label: Text('Jobs')),
                        DataColumn(label: Text('Groups')),
                        DataColumn(label: Text('Followers')),
                        DataColumn(label: Text('Admins')),
                        DataColumn(label: Text('Employees')),
                        DataColumn(label: Text('Calendar')),
                        DataColumn(label: Text('Posts')),
                      ],
                      rows: pageController.pagesData
                          .where(
                            (page) =>
                                page['id']!.toLowerCase().contains(idFilterController.text.toLowerCase()) &&
                                page['name']!.toLowerCase().contains(nameFilterController.text.toLowerCase()) &&
                                page['description']!.toLowerCase().contains(descriptionFilterController.text.toLowerCase()) &&
                                page['country']!.toLowerCase().contains(countryFilterController.text.toLowerCase()) &&
                                page['address']!.toLowerCase().contains(addressFilterController.text.toLowerCase()) &&
                                page['contactInfo']!.toLowerCase().contains(contactInfoFilterController.text.toLowerCase()) &&
                                page['specialty']!.toLowerCase().contains(specialtyFilterController.text.toLowerCase()) &&
                                page['pageType']!.toLowerCase().contains(pageTypeFilterController.text.toLowerCase()) &&
                                page['createdAt']!.toLowerCase().contains(createdAtFilterController.text.toLowerCase()) &&
                                page['updatedAt']!.toLowerCase().contains(updatedAtFilterController.text.toLowerCase()),
                          )
                          .map(
                            (page) => DataRow(
                              cells: [
                                DataCell(Text(page['id'] ?? '')),
                                DataCell(Text(page['name'] ?? '')),
                                DataCell(Text(page['description'] ?? '')),
                                DataCell(Text(page['country'] ?? '')),
                                DataCell(Text(page['address'] ?? '')),
                                DataCell(Text(page['contactInfo'] ?? '')),
                                DataCell(Text(page['specialty'] ?? '')),
                                DataCell(Text(page['pageType'] ?? '')),
                                DataCell(Text(page['createdAt'] ?? '')),
                                DataCell(Text(page['updatedAt'] ?? '')),
                                DataCell(buildActionButton('Page', page['id'] ?? '')),
                                DataCell(buildActionButton('Jobs', page['id'] ?? '')),
                                DataCell(buildActionButton('Groups', page['id'] ?? '')),
                                DataCell(buildActionButton('Followers', page['id'] ?? '')),
                                DataCell(buildActionButton('Admins', page['id'] ?? '')),
                                DataCell(buildActionButton('Employees', page['id'] ?? '')),
                                DataCell(buildActionButton('Calendar', page['id'] ?? '')),
                                DataCell(buildActionButton('Posts', page['id'] ?? '')),
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

  Widget buildActionButton(String action, String pageId) {
    return ElevatedButton(
      onPressed: () {
        print('Clicked $action for pageId: $pageId');
      },
      child: Text(action),
    );
  }
}
