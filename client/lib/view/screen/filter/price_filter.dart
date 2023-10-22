import 'package:client/view/screen/filter/RowEnterPrice%20.dart';
import 'package:flutter/material.dart';

class Price extends StatefulWidget {
  const Price({Key? key}) : super(key: key);

  @override
  _PriceState createState() => _PriceState();
}

class _PriceState extends State<Price> {
  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: MediaQuery.of(context).viewInsets.bottom > 0
                      ? MediaQuery.of(context).size.height / 1.5
                      : MediaQuery.of(context).size.height / 3.2,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              Text(
                                'Price  ',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          Container(height: 15),
                          RowEnterPrice(),
                        ],
                      ),
                      Container(height: 20),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      padding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(
          color: Colors.grey,
          width: 1.6,
        ),
      ),
      child: Text(
        "Price",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}
