import 'package:client/view/bottom_bar/search/filter/property_type_sheet%20.dart';
import 'package:flutter/material.dart';

class RowRentPrice extends StatefulWidget {
  PropertyTypeSelection selection;

  RowRentPrice({Key? key, required this.selection}) : super(key: key);

  @override
  _RowRentPriceState createState() => _RowRentPriceState();
}

class _RowRentPriceState extends State<RowRentPrice> {
  @override
  void initState() {
    super.initState();

    // if (widget.selection.rent_NoMax != 0)
    //   widget.maxController.text = widget.selection.rent_NoMax.toString();
    // if (widget.selection.rent_NoMin != 0)
    //   widget.minController.text = widget.selection.rent_NoMin.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12),
        Expanded(
          child: TextField(
            controller: widget.selection.rentMaxController,
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
                    widget.selection.rentMaxController.clear();
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
            controller: widget.selection.rentMinController,
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
                    widget.selection.rentMinController.clear();
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
