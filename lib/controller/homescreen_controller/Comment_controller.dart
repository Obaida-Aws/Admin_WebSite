import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CommentController extends GetxController {
  List<Map<String, dynamic>> commentsData = [];

  getComment() async {
    var url = "$urlStarter/admin/comments";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goToComment() async {
    var response = await getComment();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToComment();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print("dddddddddd");
     // print(responseBody);

      // Clear existing data
      commentsData.clear();

      // Iterate through comments and transform them
      for (var comment in responseBody['comments']) {
        Map<String, dynamic> transformedComment = {
          'id': comment['id'].toString(),
          'postId': comment['postId'].toString(),
          'content': comment['commentContent'],
          'date': comment['Date'].toString().split('T')[0],
        };
        commentsData.add(transformedComment);
      }

      // Now commentsData contains the transformed data
      print(commentsData);

      return true;
    }
  }
}
