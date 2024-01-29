

import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeScreenController extends GetxController {

  final RxString profileImageBytes = ''.obs;
    final Map<String, dynamic> dashboardData = {
    'Users': 0,
    'Active Users': 0,
    'Pages': 0,
    'Jobs': 0,
    'Jobs Applications': 0,
    'Groups': 0,
    'Group Meetings': 0,
    'Messages': 0,
    'Posts': 0,
  };

   getDashboard() async {
    var url = "$urlStarter/admin/getDashboard";
    var responce = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    print(responce);
    return responce;
  }

  goToDashboard() async {
    var res = await getDashboard();
    if (res.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToDashboard();
      return;
    } else if (res.statusCode == 401) {
     // _logoutController.goTosigninpage();
    }
    var resbody = jsonDecode(res.body);
    if (res.statusCode == 409 || res.statusCode == 500) {
      return resbody['message'];
    } else if (res.statusCode == 200) {
      var responseBody = jsonDecode(res.body);
      print(responseBody);
      
           
      dashboardData['Users'] = responseBody['usersCount'];
      dashboardData['Active Users'] = responseBody['activeUsersCount'];
      dashboardData['Pages'] = responseBody['pagesCount'];
      dashboardData['Jobs'] = responseBody['jobsCount'];
      dashboardData['Jobs Applications'] = responseBody['jobsApplicationsCount'];
      dashboardData['Groups'] = responseBody['groupsCount'];
      dashboardData['Group Meetings'] = responseBody['groupMeetingsCount'];
      dashboardData['Messages'] = responseBody['messagesCount'];
      dashboardData['Posts'] = responseBody['postsCount'];
   
       print("ooooooooooooo");

  print(dashboardData);

      
     
     
      return true;
    }
  }




}