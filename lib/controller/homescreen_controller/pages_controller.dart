import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PagesController extends GetxController {
  List<Map<String, String>> pagesData = [];

  getPages() async {
    var url = "$urlStarter/admin/page";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goToPages() async {
    var response = await getPages();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToPages();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);

      if (responseBody.containsKey('pages')) {
        pagesData = (responseBody['pages'] as List).map<Map<String, String>>((page) {
          return {
            'id': page['id'] ?? '',
            'name': page['name'] ?? '',
            'description': page['description'] ?? '',
            'country': page['country'] ?? '',
            'address': page['address'] ?? '',
            'contactInfo': page['contactInfo'] ?? '',
            'specialty': page['specialty'] ?? '',
            'pageType': page['pageType'] ?? '',
            'photo': page['photo'] ?? '',
            'coverImage': page['coverImage'] ?? '',
            'createdAt': page['createdAt'].toString().split('T')[0] ?? '',
            'updatedAt': page['updatedAt'].toString().split('T')[0] ?? '',
          };
        }).toList();
      }
      print("awssssssssss");
      print(pagesData);

      return true;
    }
  }
}
