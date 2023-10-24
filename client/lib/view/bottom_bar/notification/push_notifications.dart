import 'package:flutter/material.dart';

class PushNotifications extends StatefulWidget {
  const PushNotifications({Key? key}) : super(key: key);

  @override
  State<PushNotifications> createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications> {
  int _selectedValue = 1;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Push Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              "Property updates",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "You can change which homes you get alerted about in your ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    TextSpan(
                      text: "saved homes",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    TextSpan(
                      text: " and ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    TextSpan(
                      text: "saved searches",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: Column(
                children: <Widget>[
                  RadioListTile<int>(
                    value: 1,
                    groupValue: _selectedValue,
                    title: const Text(
                        "                                            Right away"),
                    onChanged: _handleRadioValueChange,
                    activeColor: Colors.green,
                  ),
                  RadioListTile<int>(
                    value: 2,
                    groupValue: _selectedValue,
                    title: const Text(
                        "                                           Once a day"),
                    onChanged: _handleRadioValueChange,
                    activeColor: Colors.green,
                  ),
                  RadioListTile<int>(
                    value: 3,
                    groupValue: _selectedValue,
                    title: const Text(
                        "                                                      None"),
                    onChanged: _handleRadioValueChange,
                    activeColor: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
