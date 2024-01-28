import 'package:adminsite/controller/homescreen_controller/Users_controller.dart';
import 'package:adminsite/controller/homescreen_controller/homescreen_controller.dart';
import 'package:adminsite/view/homescreen/Activeuser.dart';
import 'package:adminsite/view/homescreen/Comment.dart';
import 'package:adminsite/view/homescreen/Group.dart';
import 'package:adminsite/view/homescreen/Job.dart';
import 'package:adminsite/view/homescreen/Like.dart';
import 'package:adminsite/view/homescreen/Posts.dart';
import 'package:adminsite/view/homescreen/Reportpages/ReportComments.dart';
import 'package:adminsite/view/homescreen/Reportpages/ReportPages.dart';
import 'package:adminsite/view/homescreen/Reportpages/ReportUsers.dart';
import 'package:adminsite/view/homescreen/Reportpages/ReportPosts.dart';
import 'package:adminsite/view/homescreen/Temouser.dart';
import 'package:adminsite/view/homescreen/Users.dart';
import 'package:adminsite/view/homescreen/Fields.dart';
import 'package:adminsite/view/homescreen/dashboards.dart';
import 'package:adminsite/view/homescreen/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMenuItem = 'Dashboard';
  HomeScreenController controller = Get.put(HomeScreenController());
  UsersController userController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Vertical Bar with IconButtons and Text Labels
          Container(
            width: 175, // Adjust the width as needed
            color: Colors.deepPurple,
            child: SingleChildScrollView(
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
                  buildMenuItem('Fields', Icons.task),
                  buildMenuItem('Pages', Icons.pages),
                  buildMenuItem('Temp Users', Icons.people),
                  buildMenuItem('Active Users', Icons.people),
                  buildMenuItem('Comments', Icons.comment),
                  buildMenuItem('Likes', Icons.comment),
                  buildMenuItem('Groups', Icons.group),
                  buildMenuItem('Jobs', Icons.work),
                  buildMenuItem('Reports Comments', Icons.report),
                  buildMenuItem('Reports Posts', Icons.report),
                  buildMenuItem('Reports Users', Icons.report),
                  buildMenuItem('Reports Pages', Icons.report),
                  
                ],
              ),
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
   // controller.goToDashboard();
      return DashboardContent();
    case 'Users':
    
      return 
      Container(
         height: 500,
        child: User());
    case 'Posts':
      return Container(
        height: 500,
        child: PostsContent());
    case 'Fields':
      return Container(
        height: 500,
        child: Fields());
    case 'Pages':
      return Container(
        height: 500,
        child: Pages());
    case 'Reports Comments':
      return Container(
        height: 500,
        child: ReportComments());
    case 'Reports Posts':
      return Container(
        height: 500,
        child: ReportPosts());
    case 'Reports Users':
      return Container(
        height: 500,
        child: ReportUsers());
  case 'Reports Pages':
      return Container(
        height: 500,
        child: ReportPages());
  case 'Temp Users':
      return Container(
        height: 500,
        child: TempUser());
    case 'Active Users':
      return Container(
        height: 500,
        child: ActiveUsers());
          case 'Comments':
      return Container(
        height: 500,
        child: Comment());
          case 'Likes':
      return Container(
        height: 500,
        child: Like());
          case 'Groups':
      return Container(
        height: 500,
        child: Groups());
          case 'Jobs':
      return Container(
        height: 500,
        child: Jobs());
    default:
      return Text('No content available');
  }
}
}
