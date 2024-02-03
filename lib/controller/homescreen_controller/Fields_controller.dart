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
            'createdAt': field['createdAt'].toString().split('T')[0] ?? '',
            // Add more fields as needed
          };
        }).toList();
      }

      fieldsData = fieldsDataList;

      return true;
    }
  }

@override
postDeleteSystemField(field) async {
  var url = "$urlStarter/admin/systemField/$field"; // Assuming 'systemField' is the correct endpoint for deleting a system field
  var response = await http.delete(
    Uri.parse(url),
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    },
  );
  return response;
}

@override
Confirmation(field) async {
  try {
    var res = await postDeleteSystemField(field);
    if (res.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      postDeleteSystemField(field);
      return;
    } else if (res.statusCode == 401) {
      // Handle unauthorized access, e.g., navigate to login page
      // _logoutController.goTosigninpage();
    }
    print(res.body);
    print("sssssssssssssssssssssssss");
    var resBody = jsonDecode(res.body);
    print(resBody['message']);
    print(res.statusCode);
    if (res.statusCode == 409 || res.statusCode == 500) {
      print(res.statusCode);
      return resBody['message'];
    } else if (res.statusCode == 200) {
      resBody['message'] = "";
      // Handle success, e.g., navigate to another page or show a success message
      // _logoutController.goTosigninpage();
    }
  } catch (err) {
    print(err);
    return "server error";
  }
}


addField(String fieldName) async {
  var url = "$urlStarter/admin/systemField";
  try {
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({"field": fieldName}),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'Authorization': 'bearer ' + GetStorage().read('accessToken'),
      },
    );

    print(response.statusCode);

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      await addField(fieldName);
    } else if (response.statusCode == 401) {
      // Handle unauthorized access, e.g., navigate to the login page
    } else {
      var responseBody = jsonDecode(response.body);
      print(responseBody['message']);
      return responseBody['message'];
    }
  } catch (error) {
    print(error);
    return "Server error";
  }
}



}
