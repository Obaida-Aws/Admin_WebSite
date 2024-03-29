import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:adminsite/view/homescreen/Add_User/UpdateUser.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UsersController extends GetxController {
  List<Map<String, dynamic>> userData = [];

  getUser() async {
    var url = "$urlStarter/admin/user";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    print(response);
    return response;
  }

  goUser() async {
    var res = await getUser();
    if (res.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goUser();
      return;
    } else if (res.statusCode == 401) {
      // _logoutController.goTosigninpage();
    }

    var resbody = jsonDecode(res.body);

    if (res.statusCode == 409 || res.statusCode == 500) {
      return resbody['message'];
    } else if (res.statusCode == 200) {
      var usersList = resbody['users'];

      for (var user in usersList) {
        userData.add({
          'firstname': user['firstname'],
          'lastname': user['lastname'],
          'email': user['email'],
          'bio': user['bio'],
          'country': user['country'],
          'address': user['address'],
          'phone': user['phone'],
          'dateOfBirth': user['dateOfBirth'].toString().split('T')[0],
          'gender': user['Gender'], // Note: 'Gender' instead of 'gender'
          'fields': user['Fields'], // Note: 'Fields' instead of 'fields'
          'photo': user['photo'],
          'coverImage': user['coverImage'],
          'cv': user['cv'],
          'status': user['status'].toString(),
          'type': user['type'],
          'createdAt': user['createdAt'].toString().split('T')[0],
          'updatedAt': user['updatedAt'].toString().split('T')[0],
          'username': user['username'],
        });
      }

      print(userData);

      return true;
    }
  }

  // get user connections
  


List<Map<String, dynamic>> followerUserData = [];
getfollowerUsers(String username) async {
  var url = "$urlStarter/admin/connections/$username";
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToFollowersUsers(String username) async {
  var response = await getfollowerUsers(username);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToFollowersUsers(username);
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
    followerUserData.clear();

    // Extract 'tempUsers' list from the response
    List<Map<String, dynamic>> PageEmployeesList = List.from(responseBody['connection']);

    // Transform and store data in tempUserData list
  for (var pagefollowers in PageEmployeesList) {
  followerUserData.add({
    'id': pagefollowers['id'],
    'pageId': pagefollowers['senderUsername'],
    'username': pagefollowers['receiverUsername'],
    'createdAt': pagefollowers['createdAt'].toString().split('T')[0],
    'updatedAt': pagefollowers['date'].toString().split('T')[0],
  });
}


    print("Transformed Data:");
    print(followerUserData);

    return true;
  }
}



// get user Sentconnections
  


List<Map<String, dynamic>> SentconnectionsUserData = [];
getSentconnectionsUsers(String username) async {
  var url = "$urlStarter/admin/SentConnections/$username";
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToSentconnectionsUsers(String username) async {
  var response = await getSentconnectionsUsers(username);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToSentconnectionsUsers(username);
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
    SentconnectionsUserData.clear();

    // Extract 'tempUsers' list from the response
    List<Map<String, dynamic>> PageEmployeesList = List.from(responseBody['connection']);

    // Transform and store data in tempUserData list
  for (var pagefollowers in PageEmployeesList) {
  SentconnectionsUserData.add({
    'id': pagefollowers['id'],
    'pageId': pagefollowers['senderUsername'],
    'username': pagefollowers['receiverUsername'],
    'createdAt': pagefollowers['createdAt'].toString().split('T')[0],
    'updatedAt': pagefollowers['date'].toString().split('T')[0],
  });
}


    print("Transformed Data:mmmmmmmmmmmmmmmm");
    print(SentconnectionsUserData);

    return true;
  }
}





// get userApplications
  


List<Map<String, dynamic>> userApplicationsUserData = [];
getuserApplicationsUsers(String username) async {
  var url = "$urlStarter/admin/userApplications/$username";
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goTouserApplicationsUsers(String username) async {
  var response = await getuserApplicationsUsers(username);
print(response.statusCode);
  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goTouserApplicationsUsers(username);
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
    userApplicationsUserData.clear();

    // Extract 'tempUsers' list from the response
    List<Map<String, dynamic>> userApplicationsList = List.from(responseBody['userApplications']);

    // Transform and store data in tempUserData list
  for (var pagefollowers in userApplicationsList) {
  userApplicationsUserData.add({
    'id': pagefollowers['id'].toString(),
    'pageId': pagefollowers['pageJobId'].toString(),
    'username': pagefollowers['username'].toString(),
    'createdAt': pagefollowers['createdAt'].toString().split('T')[0],
    'updatedAt': pagefollowers['note'].toString(),
  });
}


    print("Transformed Data:mmmmmmmmmmmmmmmm");
    print(userApplicationsUserData);

    return true;
  }
}

// get education level
List<Map<String, dynamic>> postsData = [];

getPost(String username) async {
  var url = "$urlStarter/admin/educationLevel/$username"; // Adjust the URL to include the username
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goPosts(String username) async {
  var response = await getPost(username);
  print(response.statusCode);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goPosts(username);
    return;
  } else if (response.statusCode == 401) {
    // Handle unauthorized access
    // _logoutController.goTosigninpage();
  }

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);

    print(responseBody);

    // Extracting posts data
    var posts = responseBody['EducationLevels'];

    // Mapping posts data to the desired format
    postsData = posts
        .map<Map<String, dynamic>>((post) => {
              'postId': post['id'].toString(),
              'createdBy': post['username'].toString(),
              'postContent': post['specialty'].toString(),
              'selectedPrivacy': post['School'].toString(),
              'postDate': post['startDate'].toString().split('T')[0],
              'commentCount': post['description'],
              'likeCount': post['endDate'].toString().split('T')[0],
            })
        .toList();

    print("postsData:");
    print(postsData);

    return true;
  }
}








// get education level
List<Map<String, dynamic>> workData = [];

getwork(String username) async {
  var url = "$urlStarter/admin/workExperience/$username"; // Adjust the URL to include the username
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToWork(String username) async {
  var response = await getwork(username);
  print(response.statusCode);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToWork(username);
    return;
  } else if (response.statusCode == 401) {
    // Handle unauthorized access
    // _logoutController.goTosigninpage();
  }

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);

    print(responseBody);

    // Extracting posts data
    var posts = responseBody['WorkExperiences'];

    // Mapping posts data to the desired format
    workData = posts
        .map<Map<String, dynamic>>((post) => {
              'postId': post['id'].toString(),
              'createdBy': post['username'].toString(),
              'postContent': post['specialty'].toString(),
              'selectedPrivacy': post['company'].toString(),
              'postDate': post['startDate'].toString().split('T')[0],
              'commentCount': post['description'],
              'likeCount': post['endDate'].toString().split('T')[0],
            })
        .toList();

    print("postsData:");
    print(postsData);

    return true;
  }
}


// get post

// get page posts
List<Map<String, dynamic>> postsDataj = [];

getPosts(String username) async {
  var url = "$urlStarter/admin/userPosts/$username"; // Include pageId in the URL
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToPosts(String username) async {
  var response = await getPosts(username);
print(response.statusCode);
  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToPosts(username);
    return;
  } else if (response.statusCode == 401) {
    // Handle unauthorized access
    // _logoutController.goTosigninpage();
  }

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    // Extracting posts data
    var posts = responseBody['posts'];

    // Mapping posts data to the desired format
    postsDataj = posts
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
    print(postsDataj);

    return true;
  }
}

// go to edit user 
  @override
  Future getProfileSettingsPgae(String email) async {
    var url = "$urlStarter/user/settingsGetMainInfo?email=$email";
    var accessToken = GetStorage().read('accessToken') ?? "";
    var responce = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + accessToken,
    });
    print(responce);
    return responce;
  }

  @override
  goToProfileSettingsPgae(String email) async {
    var res = await getProfileSettingsPgae(email);
    if (res.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToProfileSettingsPgae(email);
      return;
    } else if (res.statusCode == 401) {
            print("2222222222222222222222222");

     
    }
    var resbody = jsonDecode(res.body);
    if (res.statusCode == 409) {
      return resbody['message'];
    } else if (res.statusCode == 200) {
      print(resbody['availableFields']);
      print(resbody['user']);
      GetStorage().write("photo", resbody["user"]["photo"]);
      print("sooooooooooooooooooooooooooooo");
      print([resbody["user"]]);
      Get.to(ProfileSettings(
  userData: [resbody["user"]],
  availableFields: List<Map<String, dynamic>>.from(resbody['availableFields']),
));

    }
  }
  //////////////////////////////////////////////
  
  getFields() async {
    var url = "$urlStarter/user/getJobFields";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });

    print(response.statusCode);
    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      getFields();
      return;
    } else if (response.statusCode == 401) {
    
    }

    if (response.statusCode == 409) {
      var responseBody = jsonDecode(response.body);
      print(responseBody['message']);
      return;
    } else if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

     
  /*Get.off(
    NewJobPost(
      pageId: pageId,
      availableFields: List<Map<String, dynamic>>.from(
        responseBody['availableFields'],
      ),
    ),
  );*/



      
    }

    return;
  }








  /////////////////////////////////////


// delete
  @override
postDeleteUser(username) async {
  var url = "$urlStarter/admin/user";
  var response = await http.delete(
    Uri.parse(url),
    body: jsonEncode({
      "username": username,
    }),
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    },
  );
  return response;
}

@override
Confirmation(username) async {
  try {
    var res = await postDeleteUser(username);
    if (res.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      postDeleteUser(username);
      return;
    } else if (res.statusCode == 401) {
      // Handle unauthorized access, e.g., navigate to login page
      // _logoutController.goTosigninpage();
    }
    var resBody = jsonDecode(res.body);
    print(resBody['message']);
    print(res.statusCode);
    if (res.statusCode == 409 || res.statusCode == 500) {
      print(res.statusCode);
      return resBody['message'];
    } else if (res.statusCode == 200) {
      resBody['message'] = "";
      Get.back();
      // Handle success, e.g., navigate to another page or show a success message
      // _logoutController.goTosigninpage();
    }
  } catch (err) {
    print(err);
    return "server error";
  }
}





}
