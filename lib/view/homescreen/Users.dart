import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List<Map<String, String>> userData = [
    {
      'firstname': 'John',
      'lastname': 'Doe',
      'email': 'john.doe@example.com',
      'bio': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'country': 'USA',
      'address': '123 Main St, City',
      'phone': '+1 (555) 123-4567',
      'dateOfBirth': '1990-01-01',
      'gender': 'Male',
      'fields': 'Programming',
      'photo': 'john_doe_photo.jpg',
      'coverImage': 'john_doe_cover.jpg',
      'cv': 'john_doe_cv.pdf',
      'status': 'Active',
      'type': 'User',
      'createdAt': '2022-01-01',
      'updatedAt': '2022-01-15',
      'username': 'john_doe123',
    },
    {
      'firstname': 'Jane',
      'lastname': 'Doe',
      'email': 'jane.doe@example.com',
      'bio': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'country': 'Canada',
      'address': '456 Park Ave, City',
      'phone': '+1 (555) 987-6543',
      'dateOfBirth': '1985-05-15',
      'gender': 'Female',
      'fields': 'Design',
      'photo': 'jane_doe_photo.jpg',
      'coverImage': 'jane_doe_cover.jpg',
      'cv': 'jane_doe_cv.pdf',
      'status': 'Inactive',
      'type': 'Admin',
      'createdAt': '2022-02-01',
      'updatedAt': '2022-02-10',
      'username': 'jane_doe456',
    },
     {
      'firstname': 'Jane',
      'lastname': 'Doe',
      'email': 'jane.doe@example.com',
      'bio': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'country': 'Canada',
      'address': '456 Park Ave, City',
      'phone': '+1 (555) 987-6543',
      'dateOfBirth': '1985-05-15',
      'gender': 'Female',
      'fields': 'Design',
      'photo': 'jane_doe_photo.jpg',
      'coverImage': 'jane_doe_cover.jpg',
      'cv': 'jane_doe_cv.pdf',
      'status': 'Inactive',
      'type': 'Admin',
      'createdAt': '2022-02-01',
      'updatedAt': '2022-02-10',
      'username': 'jane_doe456',
    },
     {
      'firstname': 'Jane',
      'lastname': 'Doe',
      'email': 'jane.doe@example.com',
      'bio': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'country': 'Canada',
      'address': '456 Park Ave, City',
      'phone': '+1 (555) 987-6543',
      'dateOfBirth': '1985-05-15',
      'gender': 'Female',
      'fields': 'Design',
      'photo': 'jane_doe_photo.jpg',
      'coverImage': 'jane_doe_cover.jpg',
      'cv': 'jane_doe_cv.pdf',
      'status': 'Inactive',
      'type': 'Admin',
      'createdAt': '2022-02-01',
      'updatedAt': '2022-02-10',
      'username': 'jane_doe456',
    },
     {
      'firstname': 'Jane',
      'lastname': 'Doe',
      'email': 'jane.doe@example.com',
      'bio': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'country': 'Canada',
      'address': '456 Park Ave, City',
      'phone': '+1 (555) 987-6543',
      'dateOfBirth': '1985-05-15',
      'gender': 'Female',
      'fields': 'Design',
      'photo': 'jane_doe_photo.jpg',
      'coverImage': 'jane_doe_cover.jpg',
      'cv': 'jane_doe_cv.pdf',
      'status': 'Inactive',
      'type': 'Admin',
      'createdAt': '2022-02-01',
      'updatedAt': '2022-02-10',
      'username': 'jane_doe456',
    },
     {
      'firstname': 'Jane',
      'lastname': 'Doe',
      'email': 'jane.doe@example.com',
      'bio': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'country': 'Canada',
      'address': '456 Park Ave, City',
      'phone': '+1 (555) 987-6543',
      'dateOfBirth': '1985-05-15',
      'gender': 'Female',
      'fields': 'Design',
      'photo': 'jane_doe_photo.jpg',
      'coverImage': 'jane_doe_cover.jpg',
      'cv': 'jane_doe_cv.pdf',
      'status': 'Inactive',
      'type': 'Admin',
      'createdAt': '2022-02-01',
      'updatedAt': '2022-02-10',
      'username': 'jane_doe456',
    },
     {
      'firstname': 'Jane',
      'lastname': 'Doe',
      'email': 'jane.doe@example.com',
      'bio': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'country': 'Canada',
      'address': '456 Park Ave, City',
      'phone': '+1 (555) 987-6543',
      'dateOfBirth': '1985-05-15',
      'gender': 'Female',
      'fields': 'Design',
      'photo': 'jane_doe_photo.jpg',
      'coverImage': 'jane_doe_cover.jpg',
      'cv': 'jane_doe_cv.pdf',
      'status': 'Inactive',
      'type': 'Admin',
      'createdAt': '2022-02-01',
      'updatedAt': '2022-02-10',
      'username': 'jane_doe456',
    },
    // Add more user data as needed
  ];

  @override
  Widget build(BuildContext context) {
    int userListLength = userData.length;
    double percentage = userListLength / 100.0; // Assuming the maximum length is 100

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Users: $userListLength',
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
              center: Text('$userListLength'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('First Name')),
                  DataColumn(label: Text('Last Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Bio')),
                  DataColumn(label: Text('Country')),
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Phone')),
                  DataColumn(label: Text('Date of Birth')),
                  DataColumn(label: Text('Gender')),
                  DataColumn(label: Text('Fields')),
                 // DataColumn(label: Text('Photo')),
                  DataColumn(label: Text('Cover Image')),
                  DataColumn(label: Text('CV')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Created At')),
                  DataColumn(label: Text('Updated At')),
                  DataColumn(label: Text('Connections')),
                  DataColumn(label: Text('Sent Connections')),
                  DataColumn(label: Text('Education Level')),
                  DataColumn(label: Text('Work Experience')),
                  DataColumn(label: Text('User Applications')),
                  DataColumn(label: Text('Update')),
                  DataColumn(label: Text('Delete')),
                  DataColumn(label: Text('Posts')),
                ],
                rows: userData
                    .map(
                      (user) => DataRow(
                        cells: [
                          DataCell(Text(user['firstname']!)),
                          DataCell(Text(user['lastname']!)),
                          DataCell(Text(user['email']!)),
                          DataCell(Text(user['bio']!)),
                          DataCell(Text(user['country']!)),
                          DataCell(Text(user['address']!)),
                          DataCell(Text(user['phone']!)),
                          DataCell(Text(user['dateOfBirth']!)),
                          DataCell(Text(user['gender']!)),
                          DataCell(Text(user['fields']!)),
                         // DataCell(Text(user['photo']!)),
                          DataCell(Text(user['coverImage']!)),
                          DataCell(Text(user['cv']!)),
                          DataCell(Text(user['status']!)),
                          DataCell(Text(user['type']!)),
                          DataCell(Text(user['createdAt']!)),
                          DataCell(Text(user['updatedAt']!)),
                          // Buttons for actions
                          DataCell(buildActionButton('Connections', user['username']!)),
                          DataCell(buildActionButton('Sent Connections', user['username']!)),
                          DataCell(buildActionButton('Education Level', user['username']!)),
                          DataCell(buildActionButton('Work Experience', user['username']!)),
                          DataCell(buildActionButton('User Applications', user['username']!)),
                          DataCell(buildActionButton('Update', user['username']!)),
                          DataCell(buildActionButton('Delete', user['username']!)),
                          DataCell(buildActionButton('Posts', user['username']!)),
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

  Widget buildActionButton(String action, String username) {
    return ElevatedButton(
      onPressed: () {
        // Perform action based on the button clicked with the specific username
        print('Clicked $action for username: $username');
      },
      child: Text(action),
    );
  }
}
