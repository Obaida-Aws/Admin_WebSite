import 'dart:convert';
import 'package:adminsite/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
abstract class SignUpController extends GetxController{

}





//////////////

class SignUpControllerImp extends SignUpController{

  RxBool isTextFieldEnabled5 = true.obs;
  // for date picker 
final TextEditingController startDateController = TextEditingController();
  final RxBool isSaveVisible = false.obs;
  RxString textFieldText5 = ''.obs;
 Future<void> pickStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
   

    if (pickedDate != null && pickedDate != DateTime.now()) {
      startDateController.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      isTextFieldEnabled5.value = true; // Show the "Save" button
    }
  }
  //
    void clearTextField() {
    startDateController.text = '';
    // You can also clear other related fields if needed
    textFieldText5.value = ''; // Assuming you have this variable in your controller
  }



  late TextEditingController username;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController password;
   late TextEditingController dateOfBirth;

  bool isshowpass=true;
  var responceBody;
  showPassord(){
    isshowpass=isshowpass==true?false:true;
    update();
  }
  


    @override
  Future<void> signup(firstName, lastName, userName, email, password, phone, dateOfBirth) async {
    var url = "$urlStarter/admin/user";
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "userName": userName.trim(),
          "email": email.trim(),
          "password": password.trim(),
          "phone": phone.trim(),
          "dateOfBirth": dateOfBirth.trim(),
          "firstName": firstName.trim(),
          "lastName": lastName.trim(),
        }),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer ' + GetStorage().read('accessToken'),
        });
        print("sssssssssssssssssss");
        print(response.statusCode);

    if (response.statusCode == 200) {
      // Clear text fields and navigate back
      clearTextField();
      Get.back();
    } else {
      // Handle the case when signup is not successful (you can show an error message, etc.)
      var responseBody = jsonDecode(response.body);
      print(responseBody['message']);
      // You might want to show an error message to the user, for example:
      // CustomAlertDialog(
      //   title: 'Error',
      //   icon: Icons.error,
      //   text: responseBody['message'],
      //   buttonText: 'OK',
      // );
    }
  }
  
  
  @override
  goToSignIn() {
// Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    username=TextEditingController();
    phone=TextEditingController();
    email=TextEditingController();
    password=TextEditingController();
    dateOfBirth=TextEditingController();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    phone.dispose();
    email.dispose();
    password.dispose();
    dateOfBirth.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}