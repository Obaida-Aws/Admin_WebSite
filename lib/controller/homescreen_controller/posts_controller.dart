import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostsController extends GetxController {
  List<Map<String, dynamic>> postsData = [];

  getPost() async {
    var url = "$urlStarter/admin/posts";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goPosts() async {
    var response = await getPost();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goPosts();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      // Extracting posts data
      var posts = responseBody['posts'];

      // Mapping posts data to the desired format
      postsData = posts
          .map<Map<String, dynamic>>((post) => {
                'postId': post['id'].toString(),
                'createdBy': post['createdBy'].toString(),
                'postContent': post['postContent'].toString(),
                'selectedPrivacy': post['selectedPrivacy'].toString(),
                'postDate': post['postDate'].toString().split('T')[0],
                'commentCount': post['commentCount'],
                'likeCount': post['likeCount'],
              })
          .toList();

      print("postsData:");
      print(postsData);

      return true;
    }
  }
}
