import 'dart:core';

import 'package:adminsite/view/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  

 
   await GetStorage.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
    String? accessToken=GetStorage().read("accessToken") ;
    static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(accessToken);
    print("llllllllllllllllllllllllllllllllllllll");
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
     textTheme: const TextTheme(
      displayLarge:  TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
               
      bodyLarge: TextStyle(fontSize: 14, color: Colors.grey),


     ),
      ),
      debugShowCheckedModeBanner: false,
      home:Login()
      
   //   routes: routes,
    );
  }
}
