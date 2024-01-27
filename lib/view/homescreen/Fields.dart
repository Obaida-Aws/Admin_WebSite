import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Fields extends StatefulWidget {
  @override
  _FieldsState createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  List<String> fieldNames = [
    'Field 1',
    'Field 2',
    // Add more fields as needed
  ];

  @override
  Widget build(BuildContext context) {
    int fieldsCount = fieldNames.length;
    double percentage = fieldsCount / 100.0; // Assuming the maximum length is 100

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  DataColumn(label: Text('Field Name')),
                  DataColumn(label: Text('Delete')),
                  DataColumn(label: Text('Add')),
                ],
                rows: fieldNames
                    .map(
                      (fieldName) => DataRow(
                        cells: [
                          DataCell(Text(fieldName)),
                          DataCell(buildDeleteButton(fieldName)),
                          DataCell(buildAddButton(fieldName)),
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
