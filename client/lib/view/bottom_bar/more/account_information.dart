import 'package:client/controller/account_info_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    AccountInfoContoller controller = Get.put(AccountInfoContoller());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account Information",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
              child: Image.asset("assets/images/guest.png",
                  height: 100, width: 100)),
          const SizedBox(height: 13),
          Text(
            controller.userDto?["name"] ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            controller.userDto?["email"] ?? "",
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            controller.userDto?["phoneNumber"]?.toString() ?? "",
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 60),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                SizedBox(width: 25),
                Text("Push notifications",
                    style: TextStyle(
                      fontSize: 18,
                    )),
                SizedBox(width: 158),
                Icon(Icons.keyboard_arrow_right, size: 30),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                SizedBox(width: 25),
                Text("Notifications tab",
                    style: TextStyle(
                      fontSize: 18,
                    )),
                SizedBox(width: 170),
                Icon(Icons.keyboard_arrow_right, size: 30),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                SizedBox(width: 25),
                Text("Email",
                    style: TextStyle(
                      fontSize: 18,
                    )),
                SizedBox(width: 270),
                Icon(Icons.keyboard_arrow_right, size: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
