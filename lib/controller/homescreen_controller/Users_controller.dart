import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UsersController extends GetxController {
  List<Map<String, dynamic>> userData = [];

  getUser() async {
    var url = "$urlStarter/admin/user";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    print(response);
    return response;
  }

  goUser() async {
    var res = await getUser();
    if (res.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goUser();
      return;
    } else if (res.statusCode == 401) {
      // _logoutController.goTosigninpage();
    }

    var resbody = jsonDecode(res.body);

    if (res.statusCode == 409 || res.statusCode == 500) {
      return resbody['message'];
    } else if (res.statusCode == 200) {
      var usersList = resbody['users'];

      for (var user in usersList) {
        userData.add({
          'firstname': user['firstname'],
          'lastname': user['lastname'],
          'email': user['email'],
          'bio': user['bio'],
          'country': user['country'],
          'address': user['address'],
          'phone': user['phone'],
          'dateOfBirth': user['dateOfBirth'],
          'gender': user['Gender'], // Note: 'Gender' instead of 'gender'
          'fields': user['Fields'], // Note: 'Fields' instead of 'fields'
          'photo': user['photo'],
          'coverImage': user['coverImage'],
          'cv': user['cv'],
          'status': user['status'].toString(),
          'type': user['type'],
          'createdAt': user['createdAt'],
          'updatedAt': user['updatedAt'],
          'username': user['username'],
        });
      }

      print(userData);

      return true;
    }
  }
}
