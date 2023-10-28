import 'package:client/view/onboarding/onboarding_four.dart';
import 'package:client/view/onboarding/onboarding_one.dart';
import 'package:client/view/onboarding/onboarding_three.dart';
import 'package:client/view/onboarding/onboarding_two.dart';
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
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
