import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class GroupsController extends GetxController {
  List<Map<String, dynamic>> groupsData = [];

  getGroups() async {
    var url = "$urlStarter/admin/groups";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goToGroups() async {
    var response = await getGroups();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToGroups();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
    //  print(responseBody);

      // Extracting PageGroup data
      var pageGroups = responseBody['PageGroup'];

      // Mapping PageGroup data to the desired format
     groupsData = pageGroups.map<Map<String, dynamic>>((pageGroup) {
  return {
   
    'groupId': pageGroup['groupId'].toString(),
    'pageId': pageGroup['pageId'].toString(),
    'name': pageGroup['name'].toString(),
    'description': pageGroup['description'].toString(),
    'parentGroup': pageGroup['parentGroup']?.toString() ?? '', // Default to empty string if null
    'memberSendMessage': pageGroup['memberSendMessage']?.toString()?.split('T')[0] ?? '', // Default to empty string if null
    'createdAt': pageGroup['createdAt']?.toString()?.split('T')[0] ?? '', // Default to empty string if null
    'updatedAt': pageGroup['updatedAt']?.toString()?.split('T')[0] ?? '', // Default to empty string if null
  };
}).toList();


      print("groupsData:");
      print(groupsData);

      return true;
    }
  }
}
