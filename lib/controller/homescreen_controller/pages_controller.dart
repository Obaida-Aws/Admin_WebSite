import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PagesController extends GetxController {
  List<Map<String, String>> pagesData = [];

  getPages() async {
    var url = "$urlStarter/admin/page";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goToPages() async {
    var response = await getPages();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToPages();
      return;
    } else if (response.statusCode == 401) {
      // Handle unauthorized access
      // _logoutController.goTosigninpage();
    }

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);

      if (responseBody.containsKey('pages')) {
        pagesData = (responseBody['pages'] as List).map<Map<String, String>>((page) {
          return {
            'id': page['id'] ?? '',
            'name': page['name'] ?? '',
            'description': page['description'] ?? '',
            'country': page['country'] ?? '',
            'address': page['address'] ?? '',
            'contactInfo': page['contactInfo'] ?? '',
            'specialty': page['specialty'] ?? '',
            'pageType': page['pageType'] ?? '',
            'photo': page['photo'] ?? '',
            'coverImage': page['coverImage'] ?? '',
            'createdAt': page['createdAt'].toString().split('T')[0] ?? '',
            'updatedAt': page['updatedAt'].toString().split('T')[0] ?? '',
          };
        }).toList();
      }
      print("awssssssssss");
      print(pagesData);

      return true;
    }
  }


  // get page jobs
List<Map<String, String>> jobsData = [];

getJobs(String pageId) async {
  var url = "$urlStarter/admin/jobs/$pageId"; // Include pageId in the URL
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToJobs(String pageId) async {
  var response = await getJobs(pageId);
  print(response.statusCode);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToJobs(pageId);
    return;
  } else if (response.statusCode == 401) {
    // Handle unauthorized access
    // _logoutController.goTosigninpage();
  }

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);

    // Clear existing data
    jobsData.clear();

    print(responseBody);

    // Iterate over the PageJobs and transform the data
    for (var pageJob in responseBody['PageJobs']) {
      Map<String, String> transformedData = {
        'jobId': pageJob['pageJobId'].toString(),
        'pageId': pageJob['pageId'],
        'title': 'Job Title ${pageJob['pageJobId']}',
        'fields': pageJob['Fields'],
        'description': pageJob['description'],
        'endDate': pageJob['endDate'].toString().split('T')[0],
        'createdAt': pageJob['createdAt'].toString().split('T')[0],
      };
      jobsData.add(transformedData);
    }

    print("Transformed Data:");
    print(jobsData);

    return true;
  }
}


// get page posts
List<Map<String, dynamic>> postsData = [];

getPosts(String pageId) async {
  var url = "$urlStarter/admin/pagePosts/$pageId"; // Include pageId in the URL
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToPosts(String pageId) async {
  var response = await getPosts(pageId);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToPosts(pageId);
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
// get page groups
List<Map<String, String>> groupsData = [];

getGroups(String pageId) async {
  var url = "$urlStarter/admin/groups/$pageId"; // Include pageId in the URL
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToGroups(String pageId) async {
  var response = await getGroups(pageId);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToGroups(pageId);
    return;
  } else if (response.statusCode == 401) {
    // Handle unauthorized access
    // _logoutController.goTosigninpage();
  }

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);

    // Extracting PageGroup data
    var pageGroups = responseBody['PageGroup'];

    // Mapping PageGroup data to the desired format
    groupsData = pageGroups
        .map<Map<String, String>>((pageGroup) => {
              'id': pageGroup['groupId'].toString(),
              'groupId': pageGroup['groupId'].toString(),
              'pageId': pageGroup['pageId'].toString(),
              'name': pageGroup['name'].toString(),
              'description': pageGroup['description'].toString(),
              'parentGroup': pageGroup['parentGroup'].toString(),
              'endDate': pageGroup['endDate'].toString().split('T')[0],
              'createdAt': pageGroup['createdAt'].toString().split('T')[0],
              'updatedAt': pageGroup['updatedAt'].toString().split('T')[0],
            })
        .toList();

    print("groupsData:");
    print(groupsData);

    return true;
  }
}

// get page Admins
List<Map<String, dynamic>> tempUserData = [];

getTempUsers(String pageId) async {
  var url = "$urlStarter/admin/admins/$pageId";
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToTempUsers(String pageId) async {
  var response = await getTempUsers(pageId);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToTempUsers(pageId);
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
    tempUserData.clear();

    // Extract 'tempUsers' list from the response
    List<Map<String, dynamic>> pageAdminsList = List.from(responseBody['pageAdmins']);

    // Transform and store data in tempUserData list
  for (var pageAdmin in pageAdminsList) {
  tempUserData.add({
    'id': pageAdmin['id'],
    'pageId': pageAdmin['pageId'],
    'username': pageAdmin['username'],
    'adminType': pageAdmin['adminType'],
    'createdAt': pageAdmin['createdAt'].toString().split('T')[0],
    'updatedAt': pageAdmin['updatedAt'].toString().split('T')[0],
  });
}


    print("Transformed Data:");
    print(tempUserData);

    return true;
  }
}




// get page Employees
List<Map<String, dynamic>> employeeUserData = [];

getEmployeeUsers(String pageId) async {
  var url = "$urlStarter/admin/employees/$pageId";
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToEmployeeUsers(String pageId) async {
  var response = await getEmployeeUsers(pageId);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToEmployeeUsers(pageId);
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
    employeeUserData.clear();

    // Extract 'tempUsers' list from the response
    List<Map<String, dynamic>> PageEmployeesList = List.from(responseBody['PageEmployees']);

    // Transform and store data in tempUserData list
  for (var pageEmployee in PageEmployeesList) {
  employeeUserData.add({
    'id': pageEmployee['id'],
    'pageId': pageEmployee['pageId'],
    'username': pageEmployee['username'],
    'adminType': pageEmployee['field'],
    'createdAt': pageEmployee['createdAt'].toString().split('T')[0],
    'updatedAt': pageEmployee['updatedAt'].toString().split('T')[0],
  });
}


    print("Transformed Data:");
    print(employeeUserData);

    return true;
  }
}


// get page follower

List<Map<String, dynamic>> followerUserData = [];
getfollowerUsers(String pageId) async {
  var url = "$urlStarter/admin/followers/$pageId";
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}

goToFollowersUsers(String pageId) async {
  var response = await getfollowerUsers(pageId);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToFollowersUsers(pageId);
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
    List<Map<String, dynamic>> PageEmployeesList = List.from(responseBody['pageFollowers']);

    // Transform and store data in tempUserData list
  for (var pagefollowers in PageEmployeesList) {
  followerUserData.add({
    'id': pagefollowers['id'],
    'pageId': pagefollowers['pageId'],
    'username': pagefollowers['username'],
    'createdAt': pagefollowers['createdAt'].toString().split('T')[0],
    'updatedAt': pagefollowers['updatedAt'].toString().split('T')[0],
  });
}


    print("Transformed Data:");
    print(followerUserData);

    return true;
  }
}

// get Page events
List<Map<String, String>> eventUserData = [];

getEvent(String pageId) async {
  var url = "$urlStarter/admin/calender/$pageId"; // Include pageId in the URL
  var response = await http.get(Uri.parse(url), headers: {
    'Content-type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + GetStorage().read('accessToken'),
  });
  return response;
}
goToPageEvent(String pageId) async {
  var response = await getEvent(pageId);

  if (response.statusCode == 403) {
    await getRefreshToken(GetStorage().read('refreshToken'));
    goToPageEvent(pageId);
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
    eventUserData.clear();

    // Extract 'PageCalender' list from the response
    List<Map<String, dynamic>> CalenderUsersList = List.from(responseBody['PageCalender']);

    // Transform and store data in eventUserData list
    for (var Calenderpage in CalenderUsersList) {
      eventUserData.add({
        'id': Calenderpage['id'].toString(),
        'pageId': Calenderpage['pageId'].toString(),
        'subject': Calenderpage['subject'].toString(),
        'description': Calenderpage['description'].toString(),
        'time': Calenderpage['time'].toString(), // Convert to string if needed
        'date': Calenderpage['date'].toString().split('T')[0],
      });
    }

    print("Transformed Data:");
    print(eventUserData);

    return true;
  }
}


}
