import 'package:flutter/material.dart';

class PushNotifications extends StatefulWidget {
  const PushNotifications({Key? key}) : super(key: key);

  @override
  State<PushNotifications> createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications> {
  int _selectedValue = 1; // Initial selection, 1 for "Right away"

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value ?? 1; // Default to "Right away" if value is null
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
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "You can change which homes you get alerted about in your ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16 // You can customize the text color
                          ),
                    ),
                    TextSpan(
                      text: "saved homes",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 16 // You can customize the text color
                          ),
                    ),
                    TextSpan(
                      text: " and ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16 // You can customize the text color
                          ),
                    ),
                    TextSpan(
                      text: "saved searches",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 16 // You can customize the text color
                          ),
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
                    title: Text(
                        "                                                  Right away"),
                    onChanged: _handleRadioValueChange,
                    activeColor:
                        Colors.green, // Color of the selected radio button
                  ),
                  RadioListTile<int>(
                    value: 2,
                    groupValue: _selectedValue,
                    title: Text(
                        "                                                  Once a day"),
                    onChanged: _handleRadioValueChange,
                    activeColor:
                        Colors.green, // Color of the selected radio button
                  ),
                  RadioListTile<int>(
                    value: 3,
                    groupValue: _selectedValue,
                    title: Text(
                        "                                                           None"),
                    onChanged: _handleRadioValueChange,
                    activeColor:
                        Colors.green, // Color of the selected radio button
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
