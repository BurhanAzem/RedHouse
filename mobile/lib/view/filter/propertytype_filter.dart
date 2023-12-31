import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PropertyType extends StatefulWidget {
  const PropertyType({Key? key}) : super(key: key);

  @override
  _PropertyTypeState createState() => _PropertyTypeState();
}

class _PropertyTypeState extends State<PropertyType> {
  FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        controller.buyHouseTemp = controller.buyHouse;
        controller.buyApartmentTemp = controller.buyApartment;
        controller.buyTownhouseTemp = controller.buyTownhouse;
        controller.buyCastleTemp = controller.buyCastle;
        controller.buyDepartmentTemp = controller.buyDepartment;

        controller.rentHouseTemp = controller.rentHouse;
        controller.rentApartmentTemp = controller.rentApartment;
        controller.rentTownhouseTemp = controller.rentTownhouse;
        controller.rentCastleTemp = controller.rentCastle;
        controller.rentDepartmentTemp = controller.rentDepartment;

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: MediaQuery.of(context).size.height / 1.76,
                  child: Column(
                    children: [
                      if (controller.listingType)
                        const BuyPropertType()
                      else
                        const RentPropertyType(),
                      Container(
                        width: 340,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            setState(() {
                              if (controller.listingType) {
                                controller.buyHouse = controller.buyHouseTemp;
                                controller.buyApartment =
                                    controller.buyApartmentTemp;
                                controller.buyTownhouse =
                                    controller.buyTownhouseTemp;
                                controller.buyCastle = controller.buyCastleTemp;
                                controller.buyDepartment =
                                    controller.buyDepartmentTemp;

                                controller.rentHouse = true;
                                controller.rentApartment = true;
                                controller.rentTownhouse = true;
                                controller.rentCastle = true;
                                controller.rentDepartment = true;
                              } else {
                                controller.rentHouse = controller.rentHouseTemp;
                                controller.rentApartment =
                                    controller.rentApartmentTemp;
                                controller.rentTownhouse =
                                    controller.rentTownhouseTemp;
                                controller.rentCastle =
                                    controller.rentCastleTemp;
                                controller.rentDepartment =
                                    controller.rentDepartmentTemp;

                                controller.buyHouse = true;
                                controller.buyApartment = true;
                                controller.buyTownhouse = true;
                                controller.buyCastle = true;
                                controller.buyDepartment = true;
                              }
                            });

                            // controller.propertyTypeText = controller.rentPropertyTypes();

                            controller.getProperties();

                            Navigator.pop(context);
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
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: const BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
      ),
      color: Colors.white,
      child: Container(
        width: 121,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            controller.propertyTypeText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class BuyPropertType extends StatefulWidget {
  const BuyPropertType({Key? key}) : super(key: key);

  @override
  State<BuyPropertType> createState() => _BuyPropertTypeState();
}

class _BuyPropertTypeState extends State<BuyPropertType> {
  FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PropertyTypeSheetHeading(),
        Container(height: 5),
        CheckboxListTile(
          title:  Text(
            "House",
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
        CheckboxListTile(
          title: Text(
            "Apartment Unit",
            style: TextStyle(
            fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          value: controller.buyApartmentTemp,
          onChanged: (value) {
            setState(() {
              controller.buyApartmentTemp = value!;
            });
          },
          activeColor: const Color.fromARGB(255, 11, 93, 161),
        ),
        CheckboxListTile(
          title:  Text(
            "Townhouse",
            style: TextStyle(
             fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          value: controller.buyTownhouseTemp,
          onChanged: (value) {
            setState(() {
              controller.buyTownhouseTemp = value!;
            });
          },
          activeColor: const Color.fromARGB(255, 11, 93, 161),
        ),
        CheckboxListTile(
          title:  Text(
            "Castle",
            style: TextStyle(
             fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          value: controller.buyCastleTemp,
          onChanged: (value) {
            setState(() {
              controller.buyCastleTemp = value!;
            });
          },
          activeColor: const Color.fromARGB(255, 11, 93, 161),
        ),
        CheckboxListTile(
          title:  Text(
            "Entire Department",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          value: controller.buyDepartmentTemp,
          onChanged: (value) {
            setState(() {
              controller.buyDepartmentTemp = value!;
            });
          },
          activeColor: const Color.fromARGB(255, 11, 93, 161),
        ),
        Container(height: 15),
      ],
    );
  }
}

class RentPropertyType extends StatefulWidget {
  const RentPropertyType({Key? key}) : super(key: key);

  @override
  State<RentPropertyType> createState() => _RentPropertyTypeState();
}

class _RentPropertyTypeState extends State<RentPropertyType> {
  FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PropertyTypeSheetHeading(),
        Container(height: 5),
        CheckboxListTile(
          title: Text(
            "House",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          value: controller.rentHouseTemp,
          onChanged: (value) {
            setState(() {
              controller.rentHouseTemp = value!;
            });
          },
          activeColor: const Color.fromARGB(255, 11, 93, 161),
        ),
        CheckboxListTile(
          title: Text(
            "Apartment Unit",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          value: controller.rentApartmentTemp,
          onChanged: (value) {
            setState(() {
              controller.rentApartmentTemp = value!;
            });
          },
          activeColor: const Color.fromARGB(255, 11, 93, 161),
        ),
        CheckboxListTile(
          title: Text(
            "Townhouse",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          value: controller.rentTownhouseTemp,
          onChanged: (value) {
            setState(() {
              controller.rentTownhouseTemp = value!;
            });
          },
          activeColor: const Color.fromARGB(255, 11, 93, 161),
        ),
        CheckboxListTile(
          title: Text(
            "Castle",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          value: controller.rentCastleTemp,
          onChanged: (value) {
            setState(() {
              controller.rentCastleTemp = value!;
            });
          },
          activeColor: const Color.fromARGB(255, 11, 93, 161),
        ),
        CheckboxListTile(
          title: Text(
            "Entire Department",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          value: controller.rentDepartmentTemp,
          onChanged: (value) {
            setState(() {
              controller.rentDepartmentTemp = value!;
            });
          },
          activeColor: const Color.fromARGB(255, 11, 93, 161),
        ),
        Container(height: 15),
      ],
    );
  }
}

class PropertyTypeSheetHeading extends StatelessWidget {
  const PropertyTypeSheetHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '  Property type',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 27),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
