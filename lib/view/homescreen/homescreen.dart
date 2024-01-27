import 'package:adminsite/view/homescreen/Posts.dart';
import 'package:adminsite/view/homescreen/Users.dart';
import 'package:adminsite/view/homescreen/comments.dart';
import 'package:adminsite/view/homescreen/dashboards.dart';
import 'package:adminsite/view/homescreen/likes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMenuItem = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Vertical Bar with IconButtons and Text Labels
          Container(
            width: 140, // Adjust the width as needed
            color: Colors.deepPurple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Move the CircleAvatar and Text to the top
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/coverImage.jpg'), // Replace with your image asset
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Your Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24), // Add some spacing

                // Menu items
                buildMenuItem('Dashboard', Icons.dashboard),
                buildMenuItem('Users', Icons.people),
                buildMenuItem('Posts', Icons.post_add),
                buildMenuItem('Comments', Icons.comment),
                buildMenuItem('Likes', Icons.thumb_up),
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Content based on the selected menu item
                  buildContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(String label, IconData icon) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: (){
          handleMenuItemClick(label);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(icon),
              onPressed: () {
                handleMenuItemClick(label);
              },
              color: selectedMenuItem == label ? Colors.white : Colors.black,
            ),
            Text(
              label,
              style: TextStyle(
                color: selectedMenuItem == label ? Colors.white : Colors.black,
                fontSize: 14, // Adjust font size as needed
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleMenuItemClick(String menuItem) {
    setState(() {
      selectedMenuItem = menuItem;
    });
  }

Widget buildContent() {
  switch (selectedMenuItem) {
    case 'Dashboard':
      return DashboardContent();
    case 'Users':
      return User();
    case 'Posts':
      return PostsContent();
    case 'Comments':
      return CommentsContent();
    case 'Likes':
      return LikesContent();
    default:
      return Text('No content available');
  }
}
}
