import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LikeController extends GetxController {
  List<Map<String, String>> likesData = [];

  getLike() async {
    var url = "$urlStarter/admin/likes";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goToLike() async {
    var response = await getLike();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToLike();
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
      likesData.clear();

      // Extract 'likes' list from the response
      List<Map<String, dynamic>> likesList = List.from(responseBody['likes']);

      // Transform and store data in likesData list
      for (var like in likesList) {
        likesData.add({
          'id': like['id'].toString(),
          'postId': like['postId'].toString(),
          'username': like['username'],
          'pageId': like['pageId']?.toString() ?? '', // Convert to string if not null
          'createdAt': like['createdAt'],
        });
      }

      print("awsssssss");
      print(likesData);

      return true;
    }
  }
}
