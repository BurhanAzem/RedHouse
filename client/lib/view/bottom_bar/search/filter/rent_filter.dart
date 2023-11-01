import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/view/bottom_bar/search/filter/bedbath_filter.dart';
import 'package:client/view/bottom_bar/search/filter/propertytype_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentFilter extends StatefulWidget {
  RentFilter({Key? key}) : super(key: key);

  @override
  State<RentFilter> createState() => _RentFilterState();
}

class _RentFilterState extends State<RentFilter> {
  FilterController controller = Get.put(FilterController());
  late bool house;
  late bool apartment;
  late bool townhouse;
  late bool castle;
  late bool department;

  @override
  Widget build(BuildContext context) {
    const options = [
      "Any",
      "City",
      "Village",
      "Mountain",
      "Beach",
      "Island",
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        children: [
          MaterialButton(
            onPressed: () {
              house = controller.rentHouseTemp;
              apartment = controller.rentApartmentTemp;
              townhouse = controller.rentTownhouseTemp;
              castle = controller.rentCastleTemp;
              department = controller.rentDepartmentTemp;
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
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        height: MediaQuery.of(context).size.height / 1.8,
                        child: Column(
                          children: [
                            RentPropertyType(),
                            Container(
                              width: 340,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {
                                  setState(() {
                                    house = controller.rentHouseTemp;
                                    apartment = controller.rentApartmentTemp;
                                    townhouse = controller.rentTownhouseTemp;
                                    castle = controller.rentCastleTemp;
                                    department = controller.rentDepartmentTemp;

                                    controller.buyHouse = true;
                                    controller.buyApartment = true;
                                    controller.buyTownhouse = true;
                                    controller.buyCastle = true;
                                    controller.buyDepartment = true;
                                  });

                                  Navigator.pop(context);
                                },
                                minWidth: 300,
                                height: 45,
                                color: Colors.black87,
                                child: const Center(
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                  controller.rentHouseTemp = house;
                  controller.rentApartmentTemp = apartment;
                  controller.rentTownhouseTemp = townhouse;
                  controller.rentCastleTemp = castle;
                  controller.rentDepartmentTemp = department;
                });
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" Property type",
                    style: TextStyle(fontSize: 20, color: Colors.grey[700])),
                Container(height: 4),
                Text(
                  " Any",
                  style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Container(height: 25),
          const Text("    Price", style: TextStyle(fontSize: 21)),
          Container(height: 10),
          RowRentPrice(),
          Container(height: 25),
          const BedBathRow(),
          Container(height: 25),
          const Text("    Property view", style: TextStyle(fontSize: 20)),
          Container(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButton<String>(
              value: controller.rentViewTemp,
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    controller.rentViewTemp = newValue;
                  });
                }
              },
              isExpanded: true,
              underline: const SizedBox(),
            ),
          ),
          Container(height: 25),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                if (controller.rentMinControllerTemp.text != "" &&
                    controller.rentMaxControllerTemp.text != "" &&
                    int.parse(controller.rentMinControllerTemp.text) >
                        int.parse(controller.rentMaxControllerTemp.text)) {
                  Get.snackbar("Warning",
                      "The Min limit cannot be greater than the Max limit");
                } else {
                  controller.listingType = false;

                  controller.rentHouse = controller.rentHouseTemp;
                  controller.rentApartment = controller.buyApartmentTemp;
                  controller.rentTownhouse = controller.rentTownhouseTemp;
                  controller.rentCastle = controller.rentCastleTemp;
                  controller.rentDepartment = controller.rentDepartmentTemp;

                  controller.buyMaxController.text = "";
                  controller.buyMinController.text = "";
                  controller.rentMaxController.text =
                      controller.rentMaxControllerTemp.text;
                  controller.rentMinController.text =
                      controller.rentMinControllerTemp.text;

                  controller.copyBathButton();
                  controller.copyBedButton();

                  controller.rentView = controller.rentViewTemp;
                  controller.buyView = "Any view";



                  controller.getProperties();
                  

                  Navigator.pop(context);
                }
              },
              minWidth: 300,
              height: 45,
              color: Colors.black87,
              child: const Center(
                child: Text(
                  "See 0 homes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(height: 30),
        ],
      ),
    );
  }
}

class RowRentPrice extends StatefulWidget {
  RowRentPrice({Key? key}) : super(key: key);

  @override
  _RowRentPriceState createState() => _RowRentPriceState();
}

class _RowRentPriceState extends State<RowRentPrice> {
  FilterController controller = Get.put(FilterController());

  final FocusNode _focusMinNode = FocusNode();
  final FocusNode _focusMAxNode = FocusNode();
  bool ClearMin = false;
  bool ClearMax = false;

  @override
  void initState() {
    super.initState();
    _focusMinNode.addListener(() {
      setState(() {
        ClearMin = _focusMinNode.hasFocus;
      });
    });
    _focusMAxNode.addListener(() {
      setState(() {
        ClearMax = _focusMAxNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusMinNode.dispose();
    _focusMAxNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 16),
        Expanded(
          child: TextField(
            controller: controller.rentMinControllerTemp,
            focusNode: _focusMinNode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "No min",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffix: ClearMax
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.rentMinControllerTemp.clear();
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.white,
                          )),
                    )
                  : null,
            ),
          ),
        ),
        Container(width: 15),
        Expanded(
          child: TextField(
            controller: controller.rentMaxControllerTemp,
            focusNode: _focusMAxNode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "No max",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffix: ClearMax
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.rentMaxControllerTemp.clear();
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.white,
                          )),
                    )
                  : null,
            ),
          ),
        ),
        Container(width: 16),
      ],
    );
  }
}
