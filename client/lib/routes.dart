import 'package:client/view/screen/login.dart';
import 'package:client/view/screen/onBoarding.dart';
import 'package:client/view/screen/onboardingFour.dart';
import 'package:client/view/screen/onboardingOne.dart';
import 'package:client/view/screen/onboardingThree.dart';
import 'package:client/view/screen/onboardingTwo.dart';
import 'package:client/view/screen/register_one.dart';
import 'package:client/view/screen/register_two.dart';
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
};
