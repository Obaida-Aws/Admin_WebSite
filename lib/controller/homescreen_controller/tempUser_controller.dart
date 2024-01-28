import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class TempUserController extends GetxController {
  List<Map<String, String>> tempUserData = [];

  gettempUser() async {
    var url = "$urlStarter/admin/tempUser";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goToTempUser() async {
    var response = await gettempUser();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToTempUser();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print("dddddddddd");
      print(responseBody);

      // Clear existing data
      tempUserData.clear();

      // Extract 'tempUsers' list from the response
      List<Map<String, dynamic>> tempUsersList = List.from(responseBody['tempUsers']);

      // Transform and store data in tempUserData list
      for (var tempUser in tempUsersList) {
        tempUserData.add({
          'username': tempUser['username'],
          'firstname': tempUser['firstname'],
          'lastname': tempUser['lastname'],
          'email': tempUser['email'],
          'phone': tempUser['phone'].toString(), // Convert to string if needed
          'dateOfBirth': tempUser['dateOfBirth'].toString().split('T')[0],
        });
      }

      print("kkkkkkkk");
      print(tempUserData);

      return true;
    }
  }
}
