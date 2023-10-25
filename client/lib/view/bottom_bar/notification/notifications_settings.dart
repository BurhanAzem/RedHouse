import 'package:client/view/bottom_bar/notification/notifications_tab.dart';
import 'package:client/view/bottom_bar/notification/push_notifications.dart';
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
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PushNotifications()),
              );
            },
            child: Row(
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
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NotificationsTab()),
              );
            },
            child: Row(
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
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => NotificationsTab()),
              // );
            },
            child: Row(
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
