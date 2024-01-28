import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ReportCommentController extends GetxController {
  List<Map<String, String>> repostCommentsData = [];

  getCommentReport() async {
    var url = "$urlStarter/admin/commentReport";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goToCommentReport() async {
    var response = await getCommentReport();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToCommentReport();
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
      repostCommentsData.clear();

      // Iterate through reportedComments and transform data
      List<dynamic> reportedComments = responseBody['reportedComments'];
      for (var comment in reportedComments) {
        Map<String, String> formattedComment = {
          'reportId': comment['id'].toString(),
          'content': comment['text'],
          'createdBy': comment['username'],
          'commentId': comment['commentId'].toString(),
        };

        repostCommentsData.add(formattedComment);
      }
      print("ssss");
      print(repostCommentsData);

      return true;
    }
  }
}

