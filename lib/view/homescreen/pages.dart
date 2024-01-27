import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  List<Map<String, String>> pagesData = [
    {
      'id': '1',
      'name': 'Sample Page 1',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'country': 'USA',
      'address': '123 Main St, City',
      'contactInfo': '+1 (555) 123-4567',
      'specialty': 'Technology',
      'pageType': 'Public',
      'createdAt': '2022-01-01',
      'updatedAt': '2022-01-15',
    },
    {
      'id': '2',
      'name': 'Sample Page 2',
      'description': 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'country': 'Canada',
      'address': '456 Park Ave, City',
      'contactInfo': '+1 (555) 987-6543',
      'specialty': 'Design',
      'pageType': 'Private',
      'createdAt': '2022-02-01',
      'updatedAt': '2022-02-10',
    },
    // Add more pages as needed
  ];

  @override
  Widget build(BuildContext context) {
    int pagesLength = pagesData.length;
    double percentage = pagesLength / 100.0; // Assuming the maximum length is 100

    return Scaffold(
      body: SingleChildScrollView(
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
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Country')),
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Contact Info')),
                  DataColumn(label: Text('Specialty')),
                  DataColumn(label: Text('Page Type')),
                  DataColumn(label: Text('Created At')),
                  DataColumn(label: Text('Updated At')),
                  DataColumn(label: Text('Page')),
                  DataColumn(label: Text('Jobs')),
                  DataColumn(label: Text('Groups')),
                  DataColumn(label: Text('Followers')),
                  DataColumn(label: Text('Admins')),
                  DataColumn(label: Text('Employees')),
                  DataColumn(label: Text('Calendar')),
                ],
                rows: pagesData
                    .map(
                      (page) => DataRow(
                        cells: [
                          DataCell(Text(page['id']!)),
                          DataCell(Text(page['name']!)),
                          DataCell(Text(page['description']!)),
                          DataCell(Text(page['country']!)),
                          DataCell(Text(page['address']!)),
                          DataCell(Text(page['contactInfo']!)),
                          DataCell(Text(page['specialty']!)),
                          DataCell(Text(page['pageType']!)),
                          DataCell(Text(page['createdAt']!)),
                          DataCell(Text(page['updatedAt']!)),
                          // Buttons for actions
                          DataCell(buildActionButton('Page', page['id']!)),
                          DataCell(buildActionButton('Jobs', page['id']!)),
                          DataCell(buildActionButton('Groups', page['id']!)),
                          DataCell(buildActionButton('Followers', page['id']!)),
                          DataCell(buildActionButton('Admins', page['id']!)),
                          DataCell(buildActionButton('Employees', page['id']!)),
                          DataCell(buildActionButton('Calendar', page['id']!)),
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
        // Perform action based on the button clicked with the specific pageId
        print('Clicked $action for pageId: $pageId');
      },
      child: Text(action),
    );
  }
}
