import 'package:flutter/material.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({Key? key}) : super(key: key);

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  bool newListingChecked = true;
  bool priceChangeChecked = true;
  bool openHousesChecked = true;
  bool statusChangeChecked = true;

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
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "You can change which homes you get alerted about in your ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: "saved homes",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: " and ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: "saved searches",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            CheckboxListTile(
              title: Text(
                "New listings",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              value: newListingChecked,
              onChanged: (value) {
                setState(() {
                  newListingChecked = value!;
                });
              },
              activeColor: Colors.green, // Color when selected
            ),
            CheckboxListTile(
              title: Text(
                "Price changes",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              value: priceChangeChecked,
              onChanged: (value) {
                setState(() {
                  priceChangeChecked = value!;
                });
              },
              activeColor: Colors.green,
            ),
            CheckboxListTile(
              title: Text(
                "Open houses",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              value: openHousesChecked,
              onChanged: (value) {
                setState(() {
                  openHousesChecked = value!;
                });
              },
              activeColor: Colors.green,
            ),
            CheckboxListTile(
              title: Text(
                "Status changes",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
              value: statusChangeChecked,
              onChanged: (value) {
                setState(() {
                  statusChangeChecked = value!;
                });
              },
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
