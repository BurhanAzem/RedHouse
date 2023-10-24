
import 'package:client/view/onboarding/onboardingFour.dart';
import 'package:client/view/onboarding/onboardingOne.dart';
import 'package:client/view/onboarding/onboardingThree.dart';
import 'package:client/view/onboarding/onboardingTwo.dart';
import 'package:flutter/material.dart';

class AddProperty extends StatelessWidget {
  const AddProperty({Key? key}) : super(key: key);

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