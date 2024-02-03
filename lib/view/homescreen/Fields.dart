import 'package:adminsite/controller/homescreen_controller/Fields_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Fields extends StatefulWidget {
  @override
  _FieldsState createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  final _formKey = GlobalKey<FormState>();
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
      appBar: AppBar(
        title: Text('Fields'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Show dialog to enter new field name
              showDialogToAddNewField(context);
            },
            child: Text('Add New Fields'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              CircularProgressIndicator()
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
        CircularPercentIndicator(
          animation: true,
          animationDuration: 1000,
          radius: 120,
          lineWidth: 20,
          percent: percentage,
          circularStrokeCap: CircularStrokeCap.round,
          reverse: false,
          center: Text('$fieldsCount'),
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
                    Text('Field Name'),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      width: 200,
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          labelText: 'Search Field',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DataColumn(label: Text('Created At')),
              DataColumn(label: Text('Delete')),
            ],
            rows: filteredFields
                .map(
                  (field) => DataRow(
                    cells: [
                      DataCell(Text(field['fieldName'] ?? '')),
                      DataCell(Text(field['createdAt'] ?? '')),
                      DataCell(buildDeleteButton(field['fieldName'] ?? '')),
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
        fieldController.Confirmation(fieldName);
        print('Clicked Delete for fieldName: $fieldName');
        loadData();
      },
      child: Text('Delete'),
    );
  }

  void showDialogToAddNewField(BuildContext context) {
    TextEditingController newFieldNameController = TextEditingController();

    Get.defaultDialog(
      title: 'Add New Field',
      content: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: newFieldNameController,
              decoration: InputDecoration(
                hintText: "Enter New Field Name",
                hintStyle: const TextStyle(
                  fontSize: 14,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                labelText: "FiledName",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field Name cannot be empty';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 16),
         ElevatedButton(
              onPressed: () {
                // Validate the form before performing the action
                if (_formKey.currentState!.validate()) {
                  // Form is valid, perform the action
                  String newFieldName = newFieldNameController.text;
                  if (newFieldName.isNotEmpty) {
                    fieldController.addField(newFieldName.trim());
                    print('New Field Name: $newFieldName');
                  }
                  Get.back(); // Close the dialog
                  loadData();
                }
              },
              child: Text('Add'),
            ),
        ],
      ),
    );
  }
}
