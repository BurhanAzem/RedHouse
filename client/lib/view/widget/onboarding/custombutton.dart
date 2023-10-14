import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  // final PageController pageController;

  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 220,
      child: MaterialButton(
        onPressed: () {
          // Scroll to the next page when the button is clicked
          // pageController.nextPage(
          //     duration: Duration(milliseconds: 500),
          //     curve: Curves.ease);
        },
        child: Text(
          "Next",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ), // Provide a child for the button
        color: Color(0xffd92328),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ));
  }
}
