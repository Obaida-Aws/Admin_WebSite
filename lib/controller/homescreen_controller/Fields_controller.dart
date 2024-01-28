import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class FieldsController extends GetxController {
  List<Map<String, String>> fieldsData = [];

  getFields() async {
    var url = "$urlStarter/admin/systemField";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goToFields() async {
    var response = await getFields();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToFields();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);

      List<Map<String, String>> fieldsDataList = [];

      if (responseBody.containsKey('fields')) {
        fieldsDataList = (responseBody['fields'] as List).map<Map<String, String>>((field) {
          return {
            'fieldName': field['Field'] ?? '',
            'createdAt': field['createdAt'] ?? '',
            // Add more fields as needed
          };
        }).toList();
      }

      fieldsData = fieldsDataList;

      return true;
    }
  }
}
