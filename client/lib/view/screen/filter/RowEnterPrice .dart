import 'package:flutter/material.dart';

class RowEnterPrice extends StatefulWidget {
  const RowEnterPrice({Key? key}) : super(key: key);

  @override
  _RowEnterPriceState createState() => _RowEnterPriceState();
}

class _RowEnterPriceState extends State<RowEnterPrice> {
  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12),
        Expanded(
          child: TextField(
            controller: maxController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "No max",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    maxController.clear();
                  });
                },
                child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 15,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),
        Container(width: 15),
        Expanded(
          child: TextField(
            controller: minController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "No min",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    minController.clear();
                  });
                },
                child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 15,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),
        Container(width: 12),
      ],
    );
  }
}
