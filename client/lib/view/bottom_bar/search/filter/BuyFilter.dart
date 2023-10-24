import 'package:client/view/bottom_bar/search/filter/RowBuyPrice.dart';
import 'package:client/view/bottom_bar/search/filter/property_type_sheet%20.dart';
import 'package:flutter/material.dart';

class BuyFilter extends StatefulWidget {
  PropertyTypeSelection selection;

  BuyFilter({Key? key, required this.selection}) : super(key: key);

  @override
  State<BuyFilter> createState() => _BuyFilterState();
}

class _BuyFilterState extends State<BuyFilter> {
  bool apartmentChecked = true;
  bool temporaryApartmentChecked = true;
  bool homeChecked = true;
  bool temporaryHomeChecked = true;

  @override
  void initState() {
    super.initState();
    apartmentChecked =
        temporaryApartmentChecked = widget.selection.buy_ApartmentChecked;
    homeChecked = temporaryHomeChecked = widget.selection.buy_HomeChecked;
    // if (widget.selection.buy_NoMax != 0)
    //   widget.maxController.text = widget.selection.buy_NoMax.toString();
    // if (widget.selection.buy_NoMin != 0)
    //   widget.minController.text = widget.selection.buy_NoMin.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MaterialButton(
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const Text(
                                    'Property type  ',
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    temporaryApartmentChecked =
                                        !temporaryApartmentChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: temporaryApartmentChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          temporaryApartmentChecked = value!;
                                        });
                                      },
                                      activeColor:
                                          Color.fromARGB(255, 12, 173, 18),
                                    ),
                                    const Text(
                                      'Apartment',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    temporaryHomeChecked =
                                        !temporaryHomeChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: temporaryHomeChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          temporaryHomeChecked = value!;
                                        });
                                      },
                                      activeColor:
                                          Color.fromARGB(255, 12, 173, 18),
                                    ),
                                    const Text(
                                      'Single family home',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(height: 15),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onPressed: () {
                              setState(() {
                                apartmentChecked = temporaryApartmentChecked;
                                homeChecked = temporaryHomeChecked;
                              });

                              Navigator.pop(context);
                            },
                            minWidth: 300,
                            height: 45,
                            color: Colors.black87,
                            child: Center(
                              child: Text(
                                "Apply",
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
            ).whenComplete(() {
              setState(() {
                temporaryApartmentChecked = apartmentChecked;
                temporaryHomeChecked = homeChecked;
              });
            });
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Property type",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
        const Align(
            alignment: Alignment.centerRight,
            child: Text("Price    ", style: TextStyle(fontSize: 20))),
        Container(height: 15),
        RowBuyPrice(selection: widget.selection),
        Container(height: 20),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            widget.selection.listingType = true;
            widget.selection.buy_ApartmentChecked = apartmentChecked;
            widget.selection.buy_HomeChecked = homeChecked;

            // widget.selection.buy_NoMax =
            //     int.tryParse(widget.maxController.text) ?? 0;
            // widget.selection.buy_NoMin =
            //     int.tryParse(widget.minController.text) ?? 0;
            // print(widget.selection.buy_NoMax);
            // print(widget.selection.buy_NoMin);

            widget.selection.rent_TownhomeChecked = true;
            widget.selection.rent_CondoChecked = true;
            widget.selection.rentMaxController.text = "";
            widget.selection.rentMinController.text = "";
            // widget.selection.rent_NoMax = 0;
            // widget.selection.rent_NoMin = 0;
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
    );
  }
}
