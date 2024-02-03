import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ReportUsersController extends GetxController {
  List<Map<String, String>> reportUsersData = [];

  getuserReport() async {
    var url = "$urlStarter/admin/userReport";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goTouserReport() async {
    var response = await getuserReport();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goTouserReport();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      // Clear existing data
      reportUsersData.clear();
      print("jjjjjjjjjjjjjjjjj");
      print(responseBody);

      // Iterate over the reported users and transform the data
      for (var reportedUser in responseBody['reportedUser']) {
        Map<String, String> transformedData = {
          'reportId': reportedUser['id'].toString(),
          'username': reportedUser['username'],
          'reason': reportedUser['text'],
        };
        reportUsersData.add(transformedData);
      }

      print("Transformed Data:");
      print(reportUsersData);

      return true;
    }
  }
}
