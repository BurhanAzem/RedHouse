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
              "      Property updates",
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
                _buildRadioListTile(1, " Right away"),
                _buildRadioListTile(2, " Once a day"),
                _buildRadioListTile(3, " None"),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioListTile(int value, String title) {
    return RadioListTile<int>(
      value: value,
      groupValue: _selectedValue,
      onChanged: _handleRadioValueChange,
      activeColor: Colors.green,
      controlAffinity: ListTileControlAffinity.trailing,
      title: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 17.5,
            ),
          ),
        ],
      ),
    );
  }
}
