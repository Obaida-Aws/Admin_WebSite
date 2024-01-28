import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostsController extends GetxController {

  List<Map<String, String>> userData = [
  
  ];
   getPost() async {
    var url = "$urlStarter/admin/posts";
    var responce = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    print(responce);
    return responce;
  }

  goPosts() async {
   

    var res = await getPost();
     print("ggggggggg");
     print(res.statusCode);
    if (res.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goPosts();
      return;
    } else if (res.statusCode == 401) {
     // _logoutController.goTosigninpage();
    }
    var resbody = jsonDecode(res.body);
    if (res.statusCode == 409 || res.statusCode == 500) {
      return resbody['message'];
    } else if (res.statusCode == 200) {
      var responseBody = jsonDecode(res.body);
      print("hhhhhhhhhhhhhhhhhhhhhhhhpooooooooooooooo");
print(responseBody);
      
      
      
         /*  List<Map<String, String>> userData1 = [];
if (responseBody.containsKey('users')) {
  userData1 = (responseBody['users'] as List).map<Map<String, String>>((user) {
    return {
      'firstname': user['firstname'] ?? '',
      'lastname': user['lastname'] ?? '',
      'email': user['email'] ?? '',
      'bio': user['bio'] ?? '',
      'country': user['country'] ?? '',
      'address': user['address'] ?? '',
      'phone': user['phone'] ?? '',
      'dateOfBirth': user['dateOfBirth'] ?? '',
      'gender': user['Gender'] ?? '', // Note the case change here
      'fields': user['Fields'] ?? '', // Note the case change here
      'photo': user['photo'] ?? '',
      'coverImage': user['coverImage'] ?? '',
      'cv': user['cv'] ?? '',
      'status': user['status'] ?? '',
      'type': user['type'] ?? '',
      'createdAt': user['createdAt'] ?? '',
      'updatedAt': user['updatedAt'] ?? '',
      'username': user['username'] ?? '',
    };
  }).toList();
}

userData.addAll(userData1);*/


      
     
     
      return true;
    }
  }




}