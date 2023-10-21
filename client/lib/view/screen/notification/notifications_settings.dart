

import 'package:client/view/screen/notification/notifications_tab.dart';
import 'package:client/view/screen/notification/push_notifications.dart';
import 'package:flutter/material.dart';

class NotificationsSettings extends StatelessWidget {
  const NotificationsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PushNotifications()),
              );
            },
            child: Row(
              children: [
                Text("   "),
                Icon(Icons.keyboard_arrow_right),
                Text("Push notifications",
                    style: TextStyle(
                      fontSize: 17,
                    )),
              ],
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NotificationsTab()),
              );
            },
            child: Row(
              children: [
                Text("   "),
                Icon(Icons.keyboard_arrow_right),
                Text("Notifications tab",
                    style: TextStyle(
                      fontSize: 17,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
