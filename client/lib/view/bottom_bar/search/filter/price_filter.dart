import 'package:client/view/bottom_bar/search/filter/RowBuyPrice.dart';
import 'package:client/view/bottom_bar/search/filter/RowRentPrice.dart';
import 'package:client/view/bottom_bar/search/filter/property_type_sheet%20.dart';
import 'package:flutter/material.dart';

class Price extends StatefulWidget {
  PropertyTypeSelection selection;

  Price({Key? key, required this.selection}) : super(key: key);

  @override
  _PriceState createState() => _PriceState();
}

class _PriceState extends State<Price> {
  @override
  void initState() {
    super.initState();
    print(widget.selection.listingType);
    // if (widget.selection.listingType) {
    //   if (widget.selection.buy_NoMax != 0)
    //     widget.selection.buyMinController.text =
    //         widget.selection.buy_NoMax.toString();
    //   if (widget.selection.buy_NoMin != 0)
    //     widget.selection.buyMinController.text =
    //         widget.selection.buy_NoMin.toString();
    // } else {
    //   if (widget.selection.rent_NoMax != 0)
    //     widget.selection.rentMaxController.text =
    //         widget.selection.rent_NoMax.toString();
    //   if (widget.selection.rent_NoMin != 0)
    //     widget.selection.rentMinController.text =
    //         widget.selection.rent_NoMin.toString();
    // }
  }

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
                          if (widget.selection.listingType)
                            RowBuyPrice(selection: widget.selection)
                          else
                            RowRentPrice(selection: widget.selection),
                        ],
                      ),
                      Container(height: 20),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          // if (widget.selection.listingType) {
                          //   widget.selection.buy_NoMax = int.tryParse(
                          //           widget.selection.buyNaxController.text) ??
                          //       0;
                          //   widget.selection.buy_NoMin = int.tryParse(
                          //           widget.selection.buyMinController.text) ??
                          //       0;
                          // } else {
                          //   widget.selection.rent_NoMax = int.tryParse(
                          //           widget.selection.rentMaxController.text) ??
                          //       0;
                          //   widget.selection.rent_NoMin = int.tryParse(
                          //           widget.selection.rentMinController.text) ??
                          //       0;
                          // }
                          Navigator.pop(context);
                        },
                        minWidth: 300,
                        height: 45,
                        color: Colors.black87,
                        child: Center(
                          child: Text(
                            "See 0 homes",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
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
