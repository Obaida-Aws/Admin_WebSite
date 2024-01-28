import 'dart:convert';

import 'package:adminsite/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class JobsController extends GetxController {
  List<Map<String, String>> jobsData = [];

  getJobs() async {
    var url = "$urlStarter/admin/jobs";
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer ' + GetStorage().read('accessToken'),
    });
    return response;
  }

  goToJobs() async {
    var response = await getJobs();

    if (response.statusCode == 403) {
      await getRefreshToken(GetStorage().read('refreshToken'));
      goToJobs();
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
}
