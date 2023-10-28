import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/view/bottom_bar/search/filter/bedbath_filter.dart';
import 'package:client/view/bottom_bar/search/filter/propertytype_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyFilter extends StatefulWidget {
  BuyFilter({Key? key}) : super(key: key);

  @override
  State<BuyFilter> createState() => _BuyFilterState();
}

class _BuyFilterState extends State<BuyFilter> {
  FilterController controller = Get.put(FilterController());
  late bool house;
  late bool apartment;
  late bool townhouse;
  late bool castle;
  late bool department;

  @override
  Widget build(BuildContext context) {
    const options = [
      "Any view",
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
              house = controller.buyHouseTemp;
              apartment = controller.buyApartmentTemp;
              townhouse = controller.buyTownhouseTemp;
              castle = controller.buyCastleTemp;
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
                            BuyPropertType(),
                            Container(
                              width: 340,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {
                                  setState(() {
                                    house = controller.buyHouseTemp;
                                    apartment = controller.buyApartmentTemp;
                                    townhouse = controller.buyTownhouseTemp;
                                    castle = controller.buyCastleTemp;
                                    department = controller.buyDepartmentTemp;
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
                  controller.buyHouseTemp = house;
                  controller.buyApartmentTemp = apartment;
                  controller.buyTownhouseTemp = townhouse;
                  controller.buyCastleTemp = castle;
                  controller.buyDepartmentTemp = department;
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
          RowBuyPrice(),
          Container(height: 25),
          BedBathRow(),
          Container(height: 25),
          const Text("    Property view", style: TextStyle(fontSize: 20)),
          Container(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
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
              value: controller.buyViewTemp,
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    controller.buyViewTemp = newValue;
                  });
                }
              },
              isExpanded: true,
              underline: const SizedBox(),
            ),
          ),
          Container(height: 25),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                if (controller.buyMinControllerTemp.text != "" &&
                    controller.buyMaxControllerTemp.text != "" &&
                    int.parse(controller.buyMinControllerTemp.text) >
                        int.parse(controller.buyMaxControllerTemp.text)) {
                  Get.snackbar("Warning",
                      "The Min limit cannot be greater than the Max limit");
                } else {
                  controller.listingType = true;

                  controller.buyHouse = controller.buyHouseTemp;
                  controller.buyApartment = controller.buyApartmentTemp;
                  controller.buyTownhouse = controller.buyTownhouseTemp;
                  controller.buyCastle = controller.buyCastleTemp;
                  controller.buyDepartment = controller.buyDepartmentTemp;

                  controller.rentMaxController.text = "";
                  controller.rentMinController.text = "";
                  controller.buyMaxController.text =
                      controller.buyMaxControllerTemp.text;
                  controller.buyMinController.text =
                      controller.buyMinControllerTemp.text;

                  controller.copyBathButton();
                  controller.copyBedButton();

                  controller.buyView = controller.buyViewTemp;
                  controller.rentView = "Any view";

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

class RowBuyPrice extends StatefulWidget {
  RowBuyPrice({Key? key}) : super(key: key);

  @override
  _RowBuyPriceState createState() => _RowBuyPriceState();
}

class _RowBuyPriceState extends State<RowBuyPrice> {
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
            controller: controller.buyMinControllerTemp,
            focusNode: _focusMinNode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "No min",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffix: ClearMin
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.buyMinControllerTemp.clear();
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
            controller: controller.buyMaxControllerTemp,
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
                          controller.buyMaxControllerTemp.clear();
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
