import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ActiveUserController extends GetxController {
  List<Map<String, String>> activeUsersData = [];

  getactiveUser() async {
    var url = "$urlStarter/admin/activeUser";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goToActiveUser() async {
    var response = await getactiveUser();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToActiveUser();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print("dddddddddd");
      print(responseBody);

       List<dynamic> usersList = responseBody['users'];
        activeUsersData.clear();

      // Map the required fields and add to activeUsersData
      for (var user in usersList) {
        activeUsersData.add({ 
          'id': user['id'].toString(),
          'username': user['username'],
        });
      }

      print("ffffffffffffffff");
      print(activeUsersData);

      

    

      return true;
    }
  }
}
