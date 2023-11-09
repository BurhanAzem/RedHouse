import 'package:client/view/bottom_bar/notification/email_notifications%20.dart';
import 'package:client/view/bottom_bar/notification/notifications_tab.dart';
import 'package:client/view/bottom_bar/notification/push_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsSettings extends StatelessWidget {
  const NotificationsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Get.to(() => const PushNotifications());
            },
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
            onTap: () {
              Get.to(() => const NotificationsTab());
            },
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
            onTap: () {
              Get.to(() => const EmailNotifications());
            },
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
