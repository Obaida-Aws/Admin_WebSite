import 'package:adminsite/controller/homescreen_controller/Fields_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Fields extends StatefulWidget {
  @override
  _FieldsState createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  FieldsController fieldController = Get.put(FieldsController());
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await fieldController.goToFields();
    setState(() {
      isLoading = false;
    });
  }

  double calculatePercentage(int count) {
    double percentage = count / 200.0;
    if (percentage > 1.0) {
      percentage = 1.0;
    }
    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    int fieldsCount = fieldController.fieldsData.length;
    double percentage = calculatePercentage(fieldsCount);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField for searching

            if (isLoading)
              CircularProgressIndicator() // Loading indicator
            else
              buildFieldsContent(fieldsCount, percentage),
          ],
        ),
      ),
    );
  }

  Widget buildFieldsContent(int fieldsCount, double percentage) {
    List<Map<String, dynamic>> filteredFields = fieldController.fieldsData
        .where((field) => field['fieldName']!
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();

    return Column(
      children: [
        Text(
          'Fields: $fieldsCount',
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
          center: Text('$fieldsCount'),
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
                  Text('Field Name'),
                  SizedBox(width: 40,),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(
                            () {}); // Trigger a rebuild on TextField change
                      },
                      decoration: InputDecoration(
                        labelText: 'Search Field',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              )),
              DataColumn(label: Text('Created At')),
              DataColumn(label: Text('Delete')),
              DataColumn(label: Text('Add')),
            ],
            rows: filteredFields
                .map(
                  (field) => DataRow(
                    cells: [
                      DataCell(Text(field['fieldName'] ?? '')),
                      DataCell(Text(field['createdAt'] ?? '')),
                      DataCell(buildDeleteButton(field['fieldName'] ?? '')),
                      DataCell(buildAddButton(field['fieldName'] ?? '')),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildDeleteButton(String fieldName) {
    return ElevatedButton(
      onPressed: () {
        // Implement delete functionality here with the specific fieldName
        print('Clicked Delete for fieldName: $fieldName');
      },
      child: Text('Delete'),
    );
  }

  Widget buildAddButton(String fieldName) {
    return ElevatedButton(
      onPressed: () {
        // Implement add functionality here with the specific fieldName
        print('Clicked Add for fieldName: $fieldName');
      },
      child: Text('Add'),
    );
  }
}
