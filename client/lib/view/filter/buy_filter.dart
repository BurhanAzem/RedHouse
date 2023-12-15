import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/controller/map_list/map_list_controller.dart';
import 'package:client/view/filter/bedbath_filter.dart';
import 'package:client/view/filter/propertytype_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyFilter extends StatefulWidget {
  BuyFilter({Key? key}) : super(key: key);

  @override
  State<BuyFilter> createState() => _BuyFilterState();
}

class _BuyFilterState extends State<BuyFilter> {
  MapListController mapListController = Get.put(MapListController());
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

    const listingBy = [
      "Any",
      "Agent",
      "Landlord",
    ];

    return GetBuilder<FilterController>(
        init: FilterController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        // Property Type
                        MaterialButton(
                          onPressed: () {
                            house = controller.buyHouseTemp;
                            apartment = controller.buyApartmentTemp;
                            townhouse = controller.buyTownhouseTemp;
                            castle = controller.buyCastleTemp;
                            department = controller.buyDepartmentTemp;
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30))),
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(30))),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.8,
                                      child: Column(
                                        children: [
                                          const BuyPropertType(),
                                          Container(
                                            width: 340,
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  house =
                                                      controller.buyHouseTemp;
                                                  apartment = controller
                                                      .buyApartmentTemp;
                                                  townhouse = controller
                                                      .buyTownhouseTemp;
                                                  castle =
                                                      controller.buyCastleTemp;
                                                  department = controller
                                                      .buyDepartmentTemp;
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
                              const Text(" Property Type",
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                  )),
                              Container(height: 4),
                              Text(
                                " Any",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Price
                        Container(height: 30),
                        const Text("    Price",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            )),
                        Container(height: 10),
                        RowBuyPrice(),

                        // BedBathRow
                        Container(height: 30),
                        const BedBathRow(),

                        // Property View
                        Container(height: 30),
                        const Text("    Property View",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            )),
                        Container(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[700]!,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: DropdownButton<String>(
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
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

                        // Listing By
                        Container(height: 30),
                        const Text("    Listing By",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            )),
                        Container(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[700]!,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: DropdownButton<String>(
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                            value: controller.buyListingByTemp,
                            items: listingBy.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  controller.buyListingByTemp = newValue;
                                });
                              }
                            },
                            isExpanded: true,
                            underline: const SizedBox(),
                          ),
                        ),

                        // Property Size
                        Container(height: 30),
                        const Text("    Property Size",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            )),
                        Container(height: 10),
                        const BuyHomeSize(),

                        // Property Status
                        Container(height: 30),
                        const Text("    Property Status",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            )),
                        Container(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: Text(
                                  "Coming Soon",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                value: controller.buyComingSoonTemp,
                                onChanged: (value) {
                                  setState(() {
                                    controller.buyComingSoonTemp = value!;
                                  });
                                },
                                activeColor:
                                    const Color.fromARGB(255, 11, 93, 161),
                              ),
                              CheckboxListTile(
                                title: Text(
                                  "Accepting Offers",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                value: controller.buyAcceptingOffersTemp,
                                onChanged: (value) {
                                  setState(() {
                                    controller.buyAcceptingOffersTemp = value!;
                                  });
                                },
                                activeColor:
                                    const Color.fromARGB(255, 11, 93, 161),
                              ),
                              CheckboxListTile(
                                title: Text(
                                  "Pending & Under Contract",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                value: controller.buyUnderContractTemp,
                                onChanged: (value) {
                                  setState(() {
                                    controller.buyUnderContractTemp = value!;
                                  });
                                },
                                activeColor:
                                    const Color.fromARGB(255, 11, 93, 161),
                              ),
                            ],
                          ),
                        ),

                        // Parking Spots
                        Container(height: 30),
                        const Text("    Parking Spots",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            )),
                        Container(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                            controller: controller.buyParkingSpotsTemp,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.numbers),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),

                        // Basement
                        Container(height: 30),
                        const Text("    Basement",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            )),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CheckboxListTile(
                            title: Text(
                              "Has Basement",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                            value: controller.buyHouseTemp,
                            onChanged: (value) {
                              setState(() {
                                controller.buyHouseTemp = value!;
                              });
                            },
                            activeColor: const Color.fromARGB(255, 11, 93, 161),
                          ),
                        ),

                        // Year Built
                        Container(height: 30),
                        const Text("    Year Built",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            )),
                        Container(height: 10),
                        const BuyYearBuilt(),

                        // End
                        Container(height: 20),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 16),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        if ((controller.buyMinControllerTemp.text != "" &&
                                controller.buyMaxControllerTemp.text != "" &&
                                int.parse(
                                        controller.buyMinControllerTemp.text) >
                                    int.parse(controller
                                        .buyMaxControllerTemp.text)) ||
                            (controller.buySizeMinTemp.text != "" &&
                                controller.buySizeMaxTemp.text != "" &&
                                int.parse(controller.buySizeMinTemp.text) >
                                    int.parse(
                                        controller.buySizeMaxTemp.text)) ||
                            (controller.buyYearBuiltMinTemp.text != "" &&
                                controller.buyYearBuiltMaxTemp.text != "" &&
                                int.parse(controller.buyYearBuiltMinTemp.text) >
                                    int.parse(
                                        controller.buyYearBuiltMaxTemp.text))) {
                          Get.rawSnackbar(
                            snackPosition: SnackPosition.TOP,
                            messageText: const Text(
                              'The minimum limit can`t be greater than the maximum',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            isDismissible: false,
                            duration: const Duration(seconds: 3),
                            backgroundColor: Colors.red[400]!,
                            icon: const Icon(
                              Icons.warning,
                              color: Colors.white,
                              size: 35,
                            ),
                            margin: EdgeInsets.zero,
                            snackStyle: SnackStyle.GROUNDED,
                          );
                        } else {
                          controller.listingType = true;

                          // Property type
                          controller.buyHouse = controller.buyHouseTemp;
                          controller.buyApartment = controller.buyApartmentTemp;
                          controller.buyTownhouse = controller.buyTownhouseTemp;
                          controller.buyCastle = controller.buyCastleTemp;
                          controller.buyDepartment =
                              controller.buyDepartmentTemp;

                          controller.rentHouse = true;
                          controller.rentApartment = true;
                          controller.rentTownhouse = true;
                          controller.rentCastle = true;
                          controller.rentDepartment = true;

                          // Price
                          controller.rentMaxController.text = "";
                          controller.rentMinController.text = "";
                          controller.buyMaxController.text =
                              controller.buyMaxControllerTemp.text;
                          controller.buyMinController.text =
                              controller.buyMinControllerTemp.text;

                          // Bed Bath
                          controller.copyBathButton();
                          controller.copyBedButton();

                          // Property view
                          controller.buyView = controller.buyViewTemp;
                          controller.rentView = "Any";

                          // Listing by
                          controller.rentListingBy = "Any";
                          controller.buyListingBy = controller.buyListingByTemp;

                          // Property size
                          controller.rentSizeMax.text = "";
                          controller.rentSizeMin.text = "";
                          controller.buySizeMax.text =
                              controller.buySizeMaxTemp.text;
                          controller.buySizeMin.text =
                              controller.buySizeMinTemp.text;

                          // Rent type
                          controller.rentType = "All";

                          // Property status
                          controller.rentComingSoon = true;
                          controller.rentAcceptingOffers = true;
                          controller.rentUnderContract = true;
                          controller.buyComingSoon =
                              controller.buyComingSoonTemp;
                          controller.buyAcceptingOffers =
                              controller.buyAcceptingOffersTemp;
                          controller.buyUnderContract =
                              controller.buyUnderContractTemp;

                          // Parking spots
                          controller.buyParkingSpots.text =
                              controller.buyParkingSpotsTemp.text;
                          controller.rentParkingSpots.text = "";

                          // Basement
                          controller.rentBasement = true;
                          controller.buyBasement = controller.buyBasementTemp;

                          //
                          controller.formatPriceRange(
                            controller.buyMinController,
                            controller.buyMaxController,
                          );
                          controller.formatBedBath();
                          controller.checkFiltersON();
                          controller.getProperties();
                          mapListController.isLoading = true;
                          Navigator.pop(context);
                        }
                      },
                      minWidth: 300,
                      height: 45,
                      color: Colors.black87,
                      child: const Center(
                        child: Text(
                          "See  homes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}

// Others widgets

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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
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

class BuyHomeSize extends StatefulWidget {
  const BuyHomeSize({Key? key}) : super(key: key);

  @override
  _BuyHomeSizeState createState() => _BuyHomeSizeState();
}

class _BuyHomeSizeState extends State<BuyHomeSize> {
  FilterController controller = Get.put(FilterController());

  final FocusNode _focusMinNode = FocusNode();
  final FocusNode _focusMAxNode = FocusNode();
  bool clearMin = false;
  bool clearMax = false;

  @override
  void initState() {
    super.initState();
    _focusMinNode.addListener(() {
      setState(() {
        clearMin = _focusMinNode.hasFocus;
      });
    });
    _focusMAxNode.addListener(() {
      setState(() {
        clearMax = _focusMAxNode.hasFocus;
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            controller: controller.buySizeMinTemp,
            focusNode: _focusMinNode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "No min",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffix: clearMin
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.buySizeMinTemp.clear();
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            controller: controller.buySizeMaxTemp,
            focusNode: _focusMAxNode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "No max",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffix: clearMax
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.buySizeMaxTemp.clear();
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

class BuyYearBuilt extends StatefulWidget {
  const BuyYearBuilt({Key? key}) : super(key: key);

  @override
  _BuyYearBuiltState createState() => _BuyYearBuiltState();
}

class _BuyYearBuiltState extends State<BuyYearBuilt> {
  FilterController controller = Get.put(FilterController());

  final FocusNode _focusMinNode = FocusNode();
  final FocusNode _focusMAxNode = FocusNode();
  bool clearMin = false;
  bool clearMax = false;

  @override
  void initState() {
    super.initState();
    _focusMinNode.addListener(() {
      setState(() {
        clearMin = _focusMinNode.hasFocus;
      });
    });
    _focusMAxNode.addListener(() {
      setState(() {
        clearMax = _focusMAxNode.hasFocus;
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            controller: controller.buyYearBuiltMinTemp,
            focusNode: _focusMinNode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "No min",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffix: clearMin
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.buyYearBuiltMinTemp.clear();
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            controller: controller.buyYearBuiltMaxTemp,
            focusNode: _focusMAxNode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "No max",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffix: clearMax
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.buyYearBuiltMaxTemp.clear();
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
