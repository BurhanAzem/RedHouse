import 'package:client/view/bottom_bar/search/filter/property_type_sheet%20.dart';
import 'package:flutter/material.dart';

class PropertyType extends StatefulWidget {
  PropertyTypeSelection selection;
  PropertyType({Key? key, required this.selection}) : super(key: key);

  @override
  _PropertyTypeState createState() => _PropertyTypeState();
}

class _PropertyTypeState extends State<PropertyType> {
  late bool temporaryApartmentChecked;
  late bool temporaryHomeChecked;
  late bool temporaryCondoChecked;
  late bool temporaryTownhomeChecked;

  // @override
  // void initState() {
  //   super.initState();
  //   temporaryApartmentChecked = widget.selection.buy_ApartmentChecked;
  //   temporaryHomeChecked = widget.selection.buy_HomeChecked;
  //   temporaryCondoChecked = widget.selection.rent_CondoChecked;
  //   temporaryTownhomeChecked = widget.selection.rent_TownhomeChecked;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        print(widget.selection.listingType);
        print("****************************************************");

        if (widget.selection.listingType) {
          temporaryApartmentChecked = widget.selection.buy_ApartmentChecked;
          temporaryHomeChecked = widget.selection.buy_HomeChecked;
          print(widget.selection.buy_ApartmentChecked);
          print(widget.selection.buy_HomeChecked);
          print("====================================================");
          print(temporaryApartmentChecked);
          print(temporaryHomeChecked);
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
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
                            BottomSheetHeading(),
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
                                  temporaryHomeChecked = !temporaryHomeChecked;
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
                              widget.selection.buy_ApartmentChecked =
                                  temporaryApartmentChecked;
                              widget.selection.buy_HomeChecked =
                                  temporaryHomeChecked;
                            });
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
          ).whenComplete(() {
            setState(() {
              temporaryApartmentChecked = widget.selection.buy_ApartmentChecked;
              temporaryHomeChecked = widget.selection.buy_HomeChecked;
            });
          });
        } else {
          temporaryCondoChecked = widget.selection.rent_CondoChecked;
          temporaryTownhomeChecked = widget.selection.rent_TownhomeChecked;
          print(widget.selection.rent_CondoChecked);
          print(widget.selection.rent_TownhomeChecked);
          print("====================================================");
          print(temporaryCondoChecked);
          print(temporaryTownhomeChecked);
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
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
                            BottomSheetHeading(),
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
                              widget.selection.rent_CondoChecked =
                                  temporaryCondoChecked;
                              widget.selection.rent_TownhomeChecked =
                                  temporaryTownhomeChecked;
                            });
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
          ).whenComplete(() {
            setState(() {
              temporaryCondoChecked = widget.selection.rent_CondoChecked;
              temporaryTownhomeChecked = widget.selection.rent_TownhomeChecked;
            });
          });
        }
      },
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(
          color: Colors.grey,
          width: 1.6,
        ),
      ),
      child: Container(
        width: 121,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Property type",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      color: Colors.white,
    );
  }
}

class BottomSheetHeading extends StatelessWidget {
  const BottomSheetHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const Text(
          'Property type  ',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
