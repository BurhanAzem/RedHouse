import 'package:client/controller/account_info_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountHistory extends StatelessWidget {
  const AccountHistory({super.key});

  @override
  Widget build(BuildContext context) {
    AccountInfoContoller controller = Get.put(AccountInfoContoller());

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset("assets/images/guest.png",
                  height: 120, width: 120)),
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
        ],
      ),
    );
  }
}
