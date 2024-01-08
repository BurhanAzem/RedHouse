import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/main.dart';
import 'package:client/view/more/my_feedback.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    LoginControllerImp loginController = Get.put(LoginControllerImp());

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Account Information",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(0, 153, 115, 1),
            ),
            child: Center(
              child: Text(
                loginController
                    .getShortenedName(loginController.userDto?["name"] ?? ""),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            loginController.userDto?["name"] ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            loginController.userDto?["email"] ?? "",
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            loginController.userDto?["phoneNumber"]?.toString() ?? "",
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 55),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                SizedBox(width: 25),
                Icon(
                  Icons.contact_page,
                ),
                SizedBox(width: 3),
                Text("Update Status", style: TextStyle(fontSize: 18)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.keyboard_arrow_right, size: 28),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                SizedBox(width: 25),
                Icon(
                  FontAwesomeIcons.userGroup,
                  size: 17,
                ),
                SizedBox(width: 10),
                Text("Change Profile", style: TextStyle(fontSize: 18)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.keyboard_arrow_right, size: 28),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                SizedBox(width: 25),
                Icon(
                  FontAwesomeIcons.palette,
                  size: 19.5,
                ),
                SizedBox(width: 7),
                Text("Change Theme",
                    style: TextStyle(
                      fontSize: 18,
                    )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.keyboard_arrow_right, size: 28),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                SizedBox(width: 25),
                Icon(
                  Icons.settings_rounded,
                  size: 23,
                ),
                SizedBox(width: 5),
                Text("Settings & privacy",
                    style: TextStyle(
                      fontSize: 18,
                    )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.keyboard_arrow_right, size: 28),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Get.to(() => MyFeedback());
            },
            child: const Row(
              children: [
                SizedBox(width: 25),
                Icon(
                  Icons.feedback,
                  size: 22,
                ),
                SizedBox(width: 7),
                Text("Feedback",
                    style: TextStyle(
                      fontSize: 18,
                    )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.keyboard_arrow_right, size: 28),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              sharepref!.clear();
              Get.offAllNamed("/login");
            },
            child: const Row(
              children: [
                SizedBox(width: 27),
                Icon(
                  FontAwesomeIcons.rightFromBracket,
                  size: 19.5,
                ),
                SizedBox(width: 10),
                Text("Log out",
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
