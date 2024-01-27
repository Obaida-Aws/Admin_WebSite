import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UsersController extends GetxController {
   getUser() async {
    var url = "$urlStarter/admin/user";
    var responce = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    print(responce);
    return responce;
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
      var responseBody = jsonDecode(res.body);
      print(responseBody);
      
           
      
   
       print("ooooooooooooo");

  print(responseBody);

      
     
     
      return true;
    }
  }




}