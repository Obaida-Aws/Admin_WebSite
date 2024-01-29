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

// get post comments 
  List<Map<String, dynamic>> commentsData = [];
getComment(String postId) async {
  var url = "$urlStarter/admin/comments/$postId";
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToComment(String postId) async {
  var response = await getComment(postId);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToComment(postId);
    return;
  } else if (response.statusCode == 401) {
    // Handle unauthorized access
    // _logoutController.goTosigninpage();
  }

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    print("Response Body:");
    print(responseBody);

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


// get post likes
List<Map<String, String>> likesData = [];

getLike(String postId) async {
  var url = "$urlStarter/admin/likes/$postId"; // Include postId in the URL
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToLike(String postId) async {
  var response = await getLike(postId);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToLike(postId);
    return;
  } else if (response.statusCode == 401) {
    // Handle unauthorized access
    // _logoutController.goTosigninpage();
  }

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    print("Response Body:");
    print(responseBody);

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
        'createdAt': like['createdAt'].toString().split('T')[0],
      });
    }

    print("Transformed Data:");
    print(likesData);

    return true;
  }
}





}
