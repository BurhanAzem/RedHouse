import 'package:client/controller/account_info_contoller.dart';
import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyFeedback extends StatelessWidget {
  const MyFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    AccountInfoContoller controller = Get.put(AccountInfoContoller());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Feedback",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}