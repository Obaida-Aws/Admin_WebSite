import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ReportPostsController extends GetxController {
  List<Map<String, String>> reportPostsData = [];

  getpostReport() async {
    var url = "$urlStarter/admin/postReport";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goTopostReport() async {
    var response = await getpostReport();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goTopostReport();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      // Clear existing data

      reportPostsData.clear();
      print("dddddddddddddd");
      print(responseBody);
      // Iterate over the reported posts and transform the data
      for (var reportedPost in responseBody['reportedPosts']) {
        Map<String, String> transformedData = {
          'reportId': reportedPost['id'].toString(),
          'title': 'Post Title ${reportedPost['postId']}',
          'content': reportedPost['text'],
          'username': reportedPost['username'],
          'postId': reportedPost['postId'].toString(),
        };
        reportPostsData.add(transformedData);
      }

      print("Transformed Data:");
      print(reportPostsData);

      return true;
    }
  }
}
