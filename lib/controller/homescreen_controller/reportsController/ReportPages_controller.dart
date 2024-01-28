import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ReportPagesController extends GetxController {
  List<Map<String, String>> reportPagesData = [];

  getPageReport() async {
    var url = "$urlStarter/admin/pageReport";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goTopageReport() async {
    var response = await getPageReport();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goTopageReport();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      // Clear existing data
      reportPagesData.clear();

      // Iterate over the reported pages and transform the data
      for (var reportedPage in responseBody['reportedPage']) {
        Map<String, String> transformedData = {
          'reportId': reportedPage['id'].toString(),
          'pageName': reportedPage['pageId'],
          'reason': reportedPage['text'],
        };
        reportPagesData.add(transformedData);
      }

      print("Transformed Data:");
      print(reportPagesData);

      return true;
    }
  }
}
