import 'package:adminsite/controller/homescreen_controller/Add/Add_User_Controller.dart';
import 'package:adminsite/function/alterBox.dart';
import 'package:adminsite/function/alterText.dart';
import 'package:adminsite/function/validInput.dart';
import 'package:adminsite/global.dart';
import 'package:adminsite/view/login/ButtonAuth.dart';
import 'package:adminsite/view/login/textBody.dart';
import 'package:adminsite/view/login/textFormAuth.dart';
import 'package:adminsite/view/login/textSignUporSignib.dart';
import 'package:adminsite/view/login/textTitle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUp extends StatelessWidget {
  SignUp({super.key});
  GlobalKey<FormState> formstate = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SignUpControllerImp controller = Get.put(SignUpControllerImp());
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(),
          body:  Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 85, 191, 218).withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                      border: Border(
                        left: BorderSide(
                            color: const Color.fromARGB(255, 85, 191, 218),
                            width: 2.0), // Adjust color and width as needed
                        right: BorderSide(
                            color: const Color.fromARGB(255, 85, 191, 218),
                            width: 2.0), // Adjust color and width as needed
                      ),
                    ),
                    child: Form(
                      key: formstate,
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const TextTitleAuth(
                            text: "Add New User",
                          ),
                         
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormAuth(
                            valid: (value) {
                              firstName = value;
                              return validInput(value!, 50, 1, "username");
                            },
                            mycontroller: controller.username,
                            hinttext: "Enter Your first name",
                            labeltext: "First name",
                            iconData: Icons.person_outlined,
                          ),
                          TextFormAuth(
                            valid: (value) {
                              lastName = value;
                              return validInput(value!, 50, 1, "username");
                            },
                            mycontroller: controller.username,
                            hinttext: "Enter Your last name",
                            labeltext: "Lastname",
                            iconData: Icons.person_outlined,
                          ),
                          TextFormAuth(
                            valid: (value) {
                              userName = value;
                              return validInput(value!, 50, 5, "username");
                            },
                            mycontroller: controller.username,
                            hinttext: "Enter Your Username",
                            labeltext: "Username",
                            iconData: Icons.person_outlined,
                          ),
                          TextFormAuth(
                            valid: (value) {
                              email = value;
                              return validInput(value!, 100, 12, "email");
                            },
                            mycontroller: controller.email,
                            hinttext: "Enter Your Email",
                            labeltext: "Email",
                            iconData: Icons.email_outlined,
                          ),
                          TextFormAuth(
                            valid: (value) {
                              phone = value;
                              return validInput(value!, 15, 10, "phone");
                            },
                            mycontroller: controller.phone,
                            hinttext: "Enter Your Phone",
                            labeltext: "Phone",
                            iconData: Icons.phone_android_outlined,
                          ),
                          GetBuilder<SignUpControllerImp>(
                            builder: (controller) => TextFormAuth(
                              onTapIcon: () {
                                controller.showPassord();
                              },
                              obscureText: controller.isshowpass,
                              valid: (value) {
                                password = value;
                                return validInput(value!, 30, 8, "password");
                              },
                              mycontroller: controller.password,
                              hinttext: "Enter Your Password",
                              labeltext: "Password",
                              iconData: Icons.lock_outlined,
                            ),
                          ),
                          Obx(
                            () => Row(
                              children: [
                                SizedBox(
                                  width: 322,
                                  // margin: EdgeInsets.only(right: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextFormField(
                                      controller:
                                          controller.startDateController,
                                      readOnly: true,
                                      enabled:
                                          controller.isTextFieldEnabled5.value,
                                      onChanged: (text) {
                                        controller.textFieldText5.value = text;
                                      },
                                      /*   onFieldSubmitted: (value) {
                                print('Entered value: $value');

                              },*/

                                      decoration: InputDecoration(
                                        hintText:
                                            controller.textFieldText5.value,
                                        hintStyle: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 30),
                                        label: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 9),
                                          child: const Text("DateOfBirth"),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.date_range),
                                          onPressed: () =>
                                              controller.pickStartDate(context),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      validator: (Value) {
                                        dateOfBirth = Value;
                                        return validInput(
                                            Value!, 10, 8, "dateOfBirth");
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ButtonAuth(
                            text: "Add",
                            onPressed: () async {
                              // Call the asynchronous function within an async context
                              if (formstate.currentState!.validate()) {
                                print("Vaild");
                                var message = await controller.signup(
                                    firstName,
                                    lastName,
                                    userName,
                                    email,
                                    password,
                                    phone,
                                    dateOfBirth);
                               
                              } else {
                                print("Not Valid");
                              }
                            },
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/signup.png'),
                        width: 500,
                        height: 400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white38,
            elevation: 0.0,
            centerTitle: true,
            title: const Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          body: WillPopScope(
            onWillPop: alertExitApp,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const TextBodyAuth(
                        text:
                            "Sign Up to enjoy the benefits we offer to individuals and groups"),
                    const SizedBox(
                      height: 60,
                    ),
                    TextFormAuth(
                      valid: (value) {
                        firstName = value;
                        return validInput(value!, 50, 1, "username");
                      },
                      mycontroller: controller.username,
                      hinttext: "Enter Your first name",
                      labeltext: "First name",
                      iconData: Icons.person_outlined,
                    ),
                    TextFormAuth(
                      valid: (value) {
                        lastName = value;
                        return validInput(value!, 50, 1, "username");
                      },
                      mycontroller: controller.username,
                      hinttext: "Enter Your last name",
                      labeltext: "Lastname",
                      iconData: Icons.person_outlined,
                    ),
                    TextFormAuth(
                      valid: (value) {
                        userName = value;
                        return validInput(value!, 50, 5, "username");
                      },
                      mycontroller: controller.username,
                      hinttext: "Enter Your Username",
                      labeltext: "Username",
                      iconData: Icons.person_outlined,
                    ),
                    TextFormAuth(
                      valid: (value) {
                        email = value;
                        return validInput(value!, 100, 12, "email");
                      },
                      mycontroller: controller.email,
                      hinttext: "Enter Your Email",
                      labeltext: "Email",
                      iconData: Icons.email_outlined,
                    ),
                    TextFormAuth(
                      valid: (value) {
                        phone = value;
                        return validInput(value!, 15, 10, "phone");
                      },
                      mycontroller: controller.phone,
                      hinttext: "Enter Your Phone",
                      labeltext: "Phone",
                      iconData: Icons.phone_android_outlined,
                    ),
                    GetBuilder<SignUpControllerImp>(
                      builder: (controller) => TextFormAuth(
                        onTapIcon: () {
                          controller.showPassord();
                        },
                        obscureText: controller.isshowpass,
                        valid: (value) {
                          password = value;
                          return validInput(value!, 30, 8, "password");
                        },
                        mycontroller: controller.password,
                        hinttext: "Enter Your Password",
                        labeltext: "Password",
                        iconData: Icons.lock_outlined,
                      ),
                    ),
                    /*    TextFormAuth(
                valid: (value){
                  dateOfBirth=value;
                  return validInput(value!, 10, 8, "dateOfBirth");
                },
                mycontroller: controller.dateOfBirth,
                hinttext: "Enter Your date of birth",
                labeltext: "date of birth",
                iconData: Icons.event,
              ),*/
                    Obx(
                      () => Row(
                        children: [
                          SizedBox(
                            width: 322,
                            // margin: EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                controller: controller.startDateController,
                                readOnly: true,
                                enabled: controller.isTextFieldEnabled5.value,
                                onChanged: (text) {
                                  controller.textFieldText5.value = text;
                                },
                                /*   onFieldSubmitted: (value) {
                                print('Entered value: $value');

                              },*/

                                decoration: InputDecoration(
                                  hintText: controller.textFieldText5.value,
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 30),
                                  label: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 9),
                                    child: const Text("DateOfBirth"),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.date_range),
                                    onPressed: () =>
                                        controller.pickStartDate(context),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                validator: (Value) {
                                  dateOfBirth = Value;
                                  return validInput(
                                      Value!, 10, 8, "dateOfBirth");
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ButtonAuth(
                      text: "Sign Up",
                      onPressed: () async {
                        // Call the asynchronous function within an async context
                        if (formstate.currentState!.validate()) {
                          print("Vaild");
                          var message = await controller.signup(
                              firstName,
                              lastName,
                              userName,
                              email,
                              password,
                              phone,
                              dateOfBirth);
                          
                        } else {
                          print("Not Valid");
                        }
                      },
                      /*onPressed: () {
                 // var res = postSignin();
                  controller.signup();
                /* if(formstate.currentState!.validate()){
                        print("Vaild");
                       
                       }else{
                        print("Not Valid");
                       }*/
                },*/
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SignUporSignIn(
                      textOne: "Have an account ? ",
                      textTwo: "Sign In",
                      onTap: () {
                        controller.clearTextField();
                        controller.goToSignIn();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
    }
  }
}
