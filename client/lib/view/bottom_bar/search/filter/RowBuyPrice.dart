import 'package:client/view/bottom_bar/search/filter/property_type_sheet%20.dart';
import 'package:flutter/material.dart';

class RowBuyPrice extends StatefulWidget {
  PropertyTypeSelection selection;

  RowBuyPrice({Key? key, required this.selection}) : super(key: key);

  @override
  _RowBuyPriceState createState() => _RowBuyPriceState();
}

class _RowBuyPriceState extends State<RowBuyPrice> {
  @override
  void initState() {
    super.initState();

    // if (widget.selection.buy_NoMax != 0)
    //   widget.maxController.text = widget.selection.buy_NoMax.toString();
    // if (widget.selection.buy_NoMin != 0)
    //   widget.minController.text = widget.selection.buy_NoMin.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12),
        Expanded(
          child: TextField(
            controller: widget.selection.buyMinController,
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
                    widget.selection.buyMinController.clear();
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
            controller: widget.selection.buyMaxController,
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
                    widget.selection.buyMaxController.clear();
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
