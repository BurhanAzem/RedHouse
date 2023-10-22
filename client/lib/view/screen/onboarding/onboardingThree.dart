

import 'package:client/controller/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingThree extends StatelessWidget {
  const OnBoardingThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnBoardingControllerImp controller = Get.put(OnBoardingControllerImp());
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Red",
                  style: TextStyle(
                    color: Color(0xffd92328),
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "House",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                ),
                Image.asset("assets/images/for-sale2.jpg", scale: 1.2),
                Container(
                  height: 50,
                ),
                
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome To ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Red",
                  style: TextStyle(
                    color: Color(0xffd92328),
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "House",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ],
            ),
                Container(
                  height: 10,
                ),
                Text(
                  "Find the ideal place according to your\nneeds and expectations.",
                  textAlign: TextAlign.center, // Corrected textAlign
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
                Container(
              height: 30,
            ),                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    4,
                    (index) => Container(
                          margin: const EdgeInsets.only(right: 5),
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                          color: Color(0xffd92328),
                              borderRadius: BorderRadius.circular(10)),
                        ))
              ],
            ),
            Container(
                  height: 20,
                ),
                Container(
                  width: 220,
                  child: MaterialButton(
                      onPressed: () {
                        controller.toOnBoardingFour();

                      },
                      child: Text(
                          "Next", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),), // Provide a child for the button
                      color: Color(0xffd92328),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    
                      ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
