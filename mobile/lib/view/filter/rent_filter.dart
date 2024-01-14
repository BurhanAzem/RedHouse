import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/controller/map_list/map_list_controller.dart';
import 'package:client/view/filter/bedbath_filter.dart';
import 'package:client/view/filter/propertytype_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentFilter extends StatefulWidget {
  const RentFilter({Key? key}) : super(key: key);

  @override
  State<RentFilter> createState() => _RentFilterState();
}

class _RentFilterState extends State<RentFilter> {
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

    const rentType = [
      "All",
      "For daily",
      "For monthly",
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
                            house = controller.rentHouseTemp;
                            apartment = controller.rentApartmentTemp;
                            townhouse = controller.rentTownhouseTemp;
                            castle = controller.rentCastleTemp;
                            department = controller.rentDepartmentTemp;
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
                                          const RentPropertyType(),
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
                                                      controller.rentHouseTemp;
                                                  apartment = controller
                                                      .rentApartmentTemp;
                                                  townhouse = controller
                                                      .rentTownhouseTemp;
                                                  castle =
                                                      controller.rentCastleTemp;
                                                  department = controller
                                                      .rentDepartmentTemp;
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
                        const RowRentPrice(),

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
                            value: controller.rentListingByTemp,
                            items: listingBy.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  controller.rentListingByTemp = newValue;
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
                        const RentHomeSize(),

                        // Rent Type
                        Container(height: 30),
                        const Text("    Rent Type",
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
                            value: controller.rentTypeTemp,
                            items: rentType.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  controller.rentTypeTemp = newValue;
                                });
                              }
                            },
                            isExpanded: true,
                            underline: const SizedBox(),
                          ),
                        ),

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
                                value: controller.rentComingSoonTemp,
                                onChanged: (value) {
                                  setState(() {
                                    controller.rentComingSoonTemp = value!;
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
                                value: controller.rentAcceptingOffersTemp,
                                onChanged: (value) {
                                  setState(() {
                                    controller.rentAcceptingOffersTemp = value!;
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
                                value: controller.rentUnderContractTemp,
                                onChanged: (value) {
                                  setState(() {
                                    controller.rentUnderContractTemp = value!;
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
                            controller: controller.rentParkingSpotsTemp,
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
                            value: controller.buyBasementTemp,
                            onChanged: (value) {
                              setState(() {
                                controller.buyBasementTemp = value!;
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
                        const RentYearBuilt(),

                        // End
                        Container(height: 20),
                      ],
                    ),
                  ),

                  // Button
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 16),
                    child: MaterialButton(
                      onPressed: () {
                        if ((controller.rentMinControllerTemp.text != "" &&
                                controller.rentMaxControllerTemp.text != "" &&
                                int.parse(
                                        controller.rentMinControllerTemp.text) >
                                    int.parse(controller
                                        .rentMaxControllerTemp.text)) ||
                            (controller.rentSizeMinTemp.text != "" &&
                                controller.rentSizeMaxTemp.text != "" &&
                                int.parse(controller.rentSizeMinTemp.text) >
                                    int.parse(
                                        controller.rentSizeMaxTemp.text)) ||
                            (controller.rentYearBuiltMinTemp.text != "" &&
                                controller.rentYearBuiltMaxTemp.text != "" &&
                                int.parse(
                                        controller.rentYearBuiltMinTemp.text) >
                                    int.parse(controller
                                        .rentYearBuiltMaxTemp.text))) {
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
                          controller.listingType = false;

                          // Property type
                          controller.rentHouse = controller.rentHouseTemp;
                          controller.rentApartment =
                              controller.rentApartmentTemp;
                          controller.rentTownhouse =
                              controller.rentTownhouseTemp;
                          controller.rentCastle = controller.rentCastleTemp;
                          controller.rentDepartment =
                              controller.rentDepartmentTemp;

                          controller.buyHouse = true;
                          controller.buyApartment = true;
                          controller.buyTownhouse = true;
                          controller.buyCastle = true;
                          controller.buyDepartment = true;

                          // Price
                          controller.buyMaxController.text = "";
                          controller.buyMinController.text = "";
                          controller.rentMaxController.text =
                              controller.rentMaxControllerTemp.text;
                          controller.rentMinController.text =
                              controller.rentMinControllerTemp.text;

                          // Bed Bath
                          controller.copyBathButton();
                          controller.copyBedButton();

                          // Property view
                          controller.rentView = controller.rentViewTemp;
                          controller.buyView = "Any";

                          // Listing by
                          controller.rentListingBy =
                              controller.rentListingByTemp;
                          controller.buyListingBy = "Any";

                          // Property size
                          controller.buySizeMax.text = "";
                          controller.buySizeMin.text = "";
                          controller.rentSizeMax.text =
                              controller.rentSizeMaxTemp.text;
                          controller.rentSizeMin.text =
                              controller.rentSizeMinTemp.text;

                          // Rent type
                          controller.rentType = controller.rentTypeTemp;

                          // Property status
                          controller.rentComingSoon =
                              controller.rentComingSoonTemp;
                          controller.rentAcceptingOffers =
                              controller.rentAcceptingOffersTemp;
                          controller.rentUnderContract =
                              controller.rentUnderContractTemp;
                          controller.buyComingSoon = true;
                          controller.buyAcceptingOffers = true;
                          controller.buyUnderContract = true;

                          // Parking spots
                          controller.buyParkingSpots.text = "";
                          controller.rentParkingSpots.text =
                              controller.rentParkingSpotsTemp.text;

                          // Basement
                          controller.rentBasement = controller.rentBasementTemp;
                          controller.buyBasement = true;

                          // Year built
                          controller.buyYearBuiltMax.text = "";
                          controller.buyYearBuiltMin.text = "";
                          controller.rentYearBuiltMax.text =
                              controller.rentYearBuiltMaxTemp.text;
                          controller.rentYearBuiltMin.text =
                              controller.rentYearBuiltMinTemp.text;

                          //
                          controller.formatPriceRange(
                            controller.rentMinController,
                            controller.rentMaxController,
                          );
                          controller.formatBedBath();
                          controller.checkFiltersON();
                          controller.getProperties();
                          // mapListController.isLoading = true;

                          Navigator.pop(context);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minWidth: 300,
                      height: 45,
                      color: Colors.black87,
                      child: const Center(
                        child: Text(
                          "See homes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
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

class RowRentPrice extends StatefulWidget {
  const RowRentPrice({Key? key}) : super(key: key);

  @override
  _RowRentPriceState createState() => _RowRentPriceState();
}

class _RowRentPriceState extends State<RowRentPrice> {
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
              suffix: clearMin
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
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
              suffix: clearMax
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

class RentHomeSize extends StatefulWidget {
  const RentHomeSize({Key? key}) : super(key: key);

  @override
  _RentHomeSizeState createState() => _RentHomeSizeState();
}

class _RentHomeSizeState extends State<RentHomeSize> {
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
            controller: controller.rentSizeMinTemp,
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
                          controller.rentSizeMinTemp.clear();
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
            controller: controller.rentSizeMaxTemp,
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
                          controller.rentSizeMaxTemp.clear();
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

class RentYearBuilt extends StatefulWidget {
  const RentYearBuilt({Key? key}) : super(key: key);

  @override
  _RentYearBuiltState createState() => _RentYearBuiltState();
}

class _RentYearBuiltState extends State<RentYearBuilt> {
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
            controller: controller.rentYearBuiltMinTemp,
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
                          controller.rentYearBuiltMinTemp.clear();
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
            controller: controller.rentYearBuiltMaxTemp,
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
                          controller.rentYearBuiltMaxTemp.clear();
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
