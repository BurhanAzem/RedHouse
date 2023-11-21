import 'package:client/controller/auth/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/controller/applications/applications_controller.dart';
import 'package:client/view/home_information/user_history_wdget.dart';

class MyFeedback extends StatefulWidget {
  const MyFeedback({super.key});

  @override
  State<MyFeedback> createState() => _MyFeedbackState();
}

class _MyFeedbackState extends State<MyFeedback> {
  bool isLoading = true; // Add a boolean variable for loading state
  bool isFollowed = false;
  late ApplicationsControllerImp applicationsController;
  LoginControllerImp loginController = Get.put(LoginControllerImp());

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  void loadData() async {
    applicationsController =
        Get.put(ApplicationsControllerImp(), permanent: true);
    await applicationsController.getHistoryUser(loginController.userDto?["id"]);

    setState(() {
      isLoading = false; // Set isLoading to false when data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: bodyMyFeedback(),
    );
  }

  Widget bodyMyFeedback() {
    if (applicationsController.userHistory.isEmpty) {
      return Container(
        margin: const EdgeInsetsDirectional.symmetric(vertical: 60),
        child: SingleChildScrollView(
          child: UserHistoryWidget(),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: UserHistoryWidget(),
      );
    }
  }
}
