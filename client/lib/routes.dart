import 'package:client/view/add_property/add_property_1.dart';
import 'package:client/view/add_property/add_property_2.dart';
import 'package:client/view/add_property/add_property_3.dart';
import 'package:client/view/add_property/add_property_4.dart';
import 'package:client/view/add_property/add_property_5.dart';
import 'package:client/view/add_property/add_property_6.dart';
import 'package:client/view/add_property/add_property_7.dart';
import 'package:client/view/add_property/add_property_8.dart';
import 'package:client/view/add_property/add_property_9.dart';
import 'package:client/view/bottom_bar/bottom_bar.dart';
import 'package:client/view/bottom_bar/search/search.dart';
import 'package:client/view/login.dart';
import 'package:client/view/onboarding/onBoarding.dart';
import 'package:client/view/onboarding/onboardingFour.dart';
import 'package:client/view/onboarding/onboardingOne.dart';
import 'package:client/view/onboarding/onboardingThree.dart';
import 'package:client/view/onboarding/onboardingTwo.dart';
import 'package:client/view/register/register_one.dart';
import 'package:client/view/register/register_two.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String login = "/login";
  static const String onBoarding = "/onboarding";
  static const String registerOne = "/register_one";
  static const String registerTwo = "/register_two";
  static const String onBoardingOne = "/onboarding-one";
  static const String onBoardingTwo = "/onboarding-two";
  static const String onBoardingThree = "/onboarding-three";
  static const String onBoardingFour = "/onboarding-four";
  static const String addProperty1 = "/add-property1";
  static const String addProperty2 = "/add-property2";
  static const String addProperty3 = "/add-property3";
  static const String addProperty4 = "/add-property4";
  static const String addProperty5 = "/add-property5";
  static const String addProperty6 = "/add-property6";
  static const String addProperty7 = "/add-property7";
  static const String addProperty8 = "/add-property8";
  static const String addProperty9 = "/add-property9";
  static const String search = "/go-search";
  static const String bottomBar = "/go-bottomBar";
}

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.login: (context) => const Login(),
  AppRoute.registerOne: (context) => RegisterOne(),
  AppRoute.registerTwo: (context) => RegisterTwo(),
  AppRoute.onBoarding: (context) => const OnBoarding(),
  AppRoute.onBoardingOne: (context) => const OnBoardingOne(),
  AppRoute.onBoardingTwo: (context) => const OnBoardingTwo(),
  AppRoute.onBoardingThree: (context) => const OnBoardingThree(),
  AppRoute.onBoardingFour: (context) => const OnBoardingFour(),
  AppRoute.addProperty1: (context) => AddProperty1(),
  AppRoute.addProperty2: (context) => AddProperty2(),
  AppRoute.addProperty3: (context) => AddProperty3(),
  AppRoute.addProperty4: (context) => AddProperty4(),
  AppRoute.addProperty5: (context) => AddProperty5(),
  AppRoute.addProperty6: (context) => AddProperty6(),
  AppRoute.addProperty7: (context) => AddProperty7(),
  AppRoute.addProperty8: (context) => AddProperty8(),
  AppRoute.addProperty9: (context) => AddProperty9(),
  AppRoute.search: (context) => Search(),
  AppRoute.bottomBar: (context) => BottomBar(),

};
