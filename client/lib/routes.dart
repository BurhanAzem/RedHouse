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
import 'package:client/view/bottom_bar/notification/notifications.dart';
import 'package:client/view/bottom_bar/notification/notifications_settings.dart';
import 'package:client/view/bottom_bar/search/search.dart';
import 'package:client/view/contracts/all_contracts.dart';
import 'package:client/view/contracts/contract.dart';
import 'package:client/view/history_dart/user_history.dart';
import 'package:client/view/login.dart';
import 'package:client/view/manage_properties/application.dart';
import 'package:client/view/manage_properties/manage_properties.dart';
import 'package:client/view/manage_properties/properties.dart';
import 'package:client/view/onboarding/onBoarding.dart';
import 'package:client/view/onboarding/onboarding_four.dart';
import 'package:client/view/onboarding/onboarding_one.dart';
import 'package:client/view/onboarding/onboarding_three.dart';
import 'package:client/view/onboarding/onboarding_two.dart';
import 'package:client/view/register.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String onBoarding = "/onboarding";
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
  static const String allContracts = "/all-contracts";
  static const String applicationDetails = "/application-details";
  static const String contract = "/contract";
  static const String login = "/login";
  static const String properties = "/properties";
  static const String manageProperties = "/manage-properties";
  static const String userHistory = "/user-history";

  


}

Map<String, Widget Function(BuildContext)> routes = {
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
  AppRoute.allContracts: (context) => AllContracts(),
  AppRoute.applicationDetails: (context) => ApplicationDetails(),
  AppRoute.contract: (context) => const Contract(),
  AppRoute.login: (context) => Login(),
  AppRoute.properties: (context) => const Properties(),
  AppRoute.manageProperties: (context) => const ManageProperties(),
  AppRoute.userHistory: (context) => UserHistory(),




  //________________________________________________________
  "/search": (context) => const Search(),
  "/bottom-bar": (context) => BottomBar(),
  "/notificatins": (context) => const Notifications(),
  "/notificatins-settings": (context) => const NotificationsSettings(),
  "/login": (context) => Login(),
  "/register": (context) => Register(),
};
