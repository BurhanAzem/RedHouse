// import 'package:client/lib/view/screen/OnBoardingThree.dart';
// import 'package:client/view/screen/OnBoardingTwo.dart';

import 'package:client/routes.dart';
import 'package:client/view/screen/register_one.dart';
// import 'package:client/view/screen/welcoming.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'dart:io';
 
 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'RedHouse',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: RegisterOne(),
        routes: routes,
        );
  }
}
