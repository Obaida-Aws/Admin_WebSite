import 'package:adminsite/controller/login_controller/login_controller.dart';
import 'package:adminsite/function/alterBox.dart';
import 'package:adminsite/function/alterText.dart';
import 'package:adminsite/global.dart';
import 'package:adminsite/function/validInput.dart';
import 'package:adminsite/view/login/ButtonAuth.dart';
import 'package:adminsite/view/login/logoAuth.dart';
import 'package:adminsite/view/login/textBody.dart';
import 'package:adminsite/view/login/textFormAuth.dart';
import 'package:adminsite/view/login/textSignUporSignib.dart';
import 'package:adminsite/view/login/textTitle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Login extends StatelessWidget {
  Login({super.key}) {
    firstName = "";
    lastName = "";
    userName = "";
    email = "";
    password = "";
    phone = "";
    dateOfBirth = "";
    code = "";
  }

  GlobalKey<FormState> formstate = GlobalKey();

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    if (kIsWeb) {
      return Scaffold(
        body: WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              child: Form(
                key: formstate,
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
                        child: ListView(
                          children: [
                            const SizedBox(height: 100),
                            const LogoAuth(),
                            const SizedBox(height: 30),
                            const TextTitleAuth(
                              text: "Welcome Back",
                            ),
                            const SizedBox(height: 25),
                            const TextBodyAuth(
                              text: "Sign In With Your Email And Password",
                            ),
                            const SizedBox(height: 40),
                            TextFormAuth(
                              valid: (value) {
                                email = value;
                                return validInput(value!, 100, 2, "email");
                              },
                              mycontroller: controller.email,
                              hinttext: "Enter Your Email",
                              labeltext: "Email",
                              iconData: Icons.email_outlined,
                            ),
                            GetBuilder<LoginControllerImp>(
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
                            const SizedBox(height: 15),
                            InkWell(
                              onTap: () {
                                controller.goToForgetPassword();
                              },
                              child: const Text(
                                "Forget Password",
                                textAlign: TextAlign.end,
                              ),
                            ),
                            ButtonAuth(
                              text: "Sign In",
                              onPressed: () async {
                                if (formstate.currentState!.validate()) {
                                  var message =
                                      await controller.login(email, password);
                                  (message != null)
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomAlertDialog(
                                              title: 'Error',
                                              icon: Icons.error,
                                              text: message,
                                              buttonText: 'OK',
                                            );
                                          },
                                        )
                                      : null;
                                } else {
                                  print("Not Valid");
                                }
                              },
                            ),
                          
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                                'images/login.png'), 
                            width: 500,
                            height: 500, 
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
              "Sign In",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          body: WillPopScope(
            onWillPop: alertExitApp,
            child: Container(
              // key: controller.formstate,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    const LogoAuth(),
                    const SizedBox(
                      height: 30,
                    ),
                    const TextTitleAuth(
                      text: "Welcome Back",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const TextBodyAuth(
                        text: "Sign In With Your Email And Password"),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormAuth(
                      valid: (value) {
                        email = value;
                        return validInput(value!, 100, 2, "email");
                      },
                      mycontroller: controller.email,
                      hinttext: "Enter Your Email",
                      labeltext: "Email",
                      iconData: Icons.email_outlined,
                    ),
                    GetBuilder<LoginControllerImp>(
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
                    const SizedBox(
                      height: 15,
                    ),
                   
                    ButtonAuth(
                      text: "Sign In",
                      onPressed: () async {
                        if (formstate.currentState!.validate()) {
                          var message = await controller.login(email, password);
                          (message != null)
                              ? showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomAlertDialog(
                                      title: 'Error',
                                      icon: Icons.error,
                                      text: message,
                                      buttonText: 'OK',
                                    );
                                  },
                                )
                              : null;
                        } else {
                          print("Not Valid");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SignUporSignIn(
                      textOne: "Don't have an account ? ",
                      textTwo: "Sign Up",
                      onTap: () {
                        controller.goToSignup();
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
