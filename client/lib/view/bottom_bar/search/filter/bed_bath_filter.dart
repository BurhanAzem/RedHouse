import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BedBath extends StatefulWidget {
  const BedBath({Key? key}) : super(key: key);

  @override
  _BedBathState createState() => _BedBathState();
}

class _BedBathState extends State<BedBath> {
  final BedBathController bedroomController = BedBathController();
  final BedBathController bathroomController = BedBathController();

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
                  height: MediaQuery.of(context).size.height / 1.87,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const Text(
                                'Bed / Bath  ',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          Container(height: 10),
                          const Text(
                            "Bedrooms",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            height: 72,
                            child: Obx(() {
                              return ListView(
                                scrollDirection: Axis.horizontal,
                                children: bedroomController.bedroomLabels
                                    .map((label) =>
                                        bedroomButton(label, bedroomController))
                                    .toList(),
                              );
                            }),
                          ),
                          Container(height: 15),
                          Text(
                            "Bathrooms",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            height: 72,
                            child: Obx(() {
                              return ListView(
                                scrollDirection: Axis.horizontal,
                                children: bathroomController.bathroomLabels
                                    .map((label) => bathroomButton(
                                        label, bathroomController))
                                    .toList(),
                              );
                            }),
                          ),
                        ],
                      ),
                      Container(height: 15),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {},
                        minWidth: 300,
                        height: 45,
                        color: Colors.black87,
                        child: Text(
                          "See 0 homes",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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
        "Bed / Bath",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget bedroomButton(String label, BedBathController controller) {
    return Container(
      width: label == 'Studio+' ? 90 : 60,
      margin: EdgeInsets.all(8),
      child: MaterialButton(
        child: Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
        onPressed: () {
          controller.setSelectedButton(label);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: Colors.black26,
            width: 1.6,
          ),
        ),
        color: controller.isSelected(label) ? Colors.black : Colors.white,
        textColor: controller.isSelected(label) ? Colors.white : Colors.black,
      ),
    );
  }

  Widget bathroomButton(String label, BedBathController controller) {
    return Container(
      width: 60,
      margin: EdgeInsets.all(8),
      child: MaterialButton(
        child: Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
        onPressed: () {
          controller.setSelectedButton(label);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: Colors.black26,
            width: 1.6,
          ),
        ),
        color: controller.isSelected(label) ? Colors.black : Colors.white,
        textColor: controller.isSelected(label) ? Colors.white : Colors.black,
      ),
    );
  }
}

class BedBathController extends GetxController {
  RxString selectedButton = "Any".obs;

  final List<String> bedroomLabels = [
    'Any',
    'Studio+',
    '1+',
    '2+',
    '3+',
    '4+',
    '5+',
  ];

  final List<String> bathroomLabels = [
    'Any',
    '1+',
    '2+',
    '3+',
    '4+',
    '5+',
  ];

  void setSelectedButton(String label) {
    selectedButton.value = label;
  }

  bool isSelected(String label) {
    return selectedButton.value == label;
  }
}
