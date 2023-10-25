import 'package:client/view/bottom_bar/search/filter/RowRentPrice.dart';
import 'package:client/view/bottom_bar/search/filter/property_type_sheet%20.dart';
import 'package:flutter/material.dart';

class RentFilter extends StatefulWidget {
  PropertyTypeSelection selection;

  RentFilter({
    Key? key,
    required this.selection,
  }) : super(key: key);

  @override
  State<RentFilter> createState() => _RentFilterState();
}

class _RentFilterState extends State<RentFilter> {
  bool condoChecked = true;
  bool temporaryCondoChecked = true;
  bool townhomeChecked = true;
  bool temporaryTownhomeChecked = true;

  @override
  void initState() {
    super.initState();
    condoChecked = temporaryCondoChecked = widget.selection.rent_CondoChecked;
    townhomeChecked =
        temporaryTownhomeChecked = widget.selection.rent_TownhomeChecked;

    // if (widget.selection.rent_NoMax != 0)
    //   widget.maxController.text = widget.selection.rent_NoMax.toString();
    // if (widget.selection.rent_NoMin != 0)
    //   widget.minController.text = widget.selection.rent_NoMin.toString();
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
                                    temporaryCondoChecked =
                                        !temporaryCondoChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: temporaryCondoChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          temporaryCondoChecked = value!;
                                        });
                                      },
                                      activeColor:
                                          Color.fromARGB(255, 12, 173, 18),
                                    ),
                                    const Text(
                                      'Condo',
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
                                    temporaryTownhomeChecked =
                                        !temporaryTownhomeChecked;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: temporaryTownhomeChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          temporaryTownhomeChecked = value!;
                                        });
                                      },
                                      activeColor:
                                          Color.fromARGB(255, 12, 173, 18),
                                    ),
                                    const Text(
                                      'Townhome',
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
                                condoChecked = temporaryCondoChecked;
                                townhomeChecked = temporaryTownhomeChecked;
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
                temporaryCondoChecked = condoChecked;
                temporaryTownhomeChecked = townhomeChecked;
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
            alignment: Alignment.centerLeft,
            child: Text("Price", style: TextStyle(fontSize: 20))),
        Container(height: 15),
        RowRentPrice(selection: widget.selection),
        Container(height: 20),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            widget.selection.listingType = false;
            widget.selection.rent_CondoChecked = condoChecked;
            widget.selection.rent_TownhomeChecked = townhomeChecked;

            // widget.selection.rent_NoMax =
            //     int.tryParse(widget.maxController.text) ?? 0;
            // widget.selection.rent_NoMin =
            //     int.tryParse(widget.minController.text) ?? 0;
            // print(widget.selection.rent_NoMax);
            // print(widget.selection.rent_NoMin);

            widget.selection.buy_ApartmentChecked = true;
            widget.selection.buy_HomeChecked = true;
            widget.selection.buyMaxController.text = "";
            widget.selection.buyMinController.text = "";
            // widget.selection.buy_NoMax = 0;
            // widget.selection.buy_NoMin = 0;
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
