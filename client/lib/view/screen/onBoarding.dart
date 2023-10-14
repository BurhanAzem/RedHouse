import 'package:client/view/screen/onboardingFour.dart';
import 'package:client/view/screen/onboardingOne.dart';
import 'package:client/view/screen/onboardingThree.dart';
import 'package:client/view/screen/onboardingTwo.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: <Widget>[
            OnBoardingOne(),
            OnBoardingTwo(),
            OnBoardingThree(),
            OnBoardingFour()
          ],
          scrollDirection: Axis
              .horizontal, // Set the scroll direction (horizontal or vertical)
        ),
      ),
    );
  }
}