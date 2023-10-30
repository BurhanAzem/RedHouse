import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/view/bottom_bar/search/filter/buy_filter.dart';
import 'package:client/view/bottom_bar/search/filter/rent_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class Price extends StatefulWidget {
  Price({Key? key}) : super(key: key);

  @override
  _PriceState createState() => _PriceState();
}

class _PriceState extends State<Price> {
  FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        print(
            "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
        controller.buyMaxControllerTemp.text = controller.buyMaxController.text;
        controller.buyMinControllerTemp.text = controller.buyMinController.text;
        controller.rentMaxControllerTemp.text =
            controller.rentMaxController.text;
        controller.rentMinControllerTemp.text =
            controller.rentMinController.text;

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
                  height: MediaQuery.of(context).viewInsets.bottom > 0
                      ? MediaQuery.of(context).size.height / 1.8
                      : MediaQuery.of(context).size.height / 3.5,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '  Price',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.black, size: 27),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          Container(height: 15),
                          if (controller.listingType)
                            RowBuyPrice()
                          else
                            RowRentPrice(),
                        ],
                      ),
                      Container(height: 20),
                      Container(
                        width: 340,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            if (controller.listingType) {
                              if (controller.buyMinControllerTemp.text != "" &&
                                  controller.buyMaxControllerTemp.text != "" &&
                                  int.parse(controller
                                          .buyMinControllerTemp.text) >
                                      int.parse(controller
                                          .buyMaxControllerTemp.text)) {
                                Get.snackbar("Warning",
                                    "The Min limit cannot be greater than the Max limit");
                              } else {
                                controller.rentMaxController.text = "";
                                controller.rentMinController.text = "";
                                controller.buyMaxController.text =
                                    controller.buyMaxControllerTemp.text;
                                controller.buyMinController.text =
                                    controller.buyMinControllerTemp.text;
                                Navigator.pop(context);
                              }
                            } else {
                              if (controller.rentMinControllerTemp.text != "" &&
                                  controller.rentMaxControllerTemp.text != "" &&
                                  int.parse(controller
                                          .rentMinControllerTemp.text) >
                                      int.parse(controller
                                          .rentMaxControllerTemp.text)) {
                                Get.snackbar("Warning",
                                    "The Min limit cannot be greater than the Max limit");
                              } else {
                                controller.buyMaxController.text = "";
                                controller.buyMinController.text = "";
                                controller.rentMaxController.text =
                                    controller.rentMaxControllerTemp.text;
                                controller.rentMinController.text =
                                    controller.rentMinControllerTemp.text;

                                    
                                controller.getProperties();

                                Navigator.pop(context);
                              }
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
      child: const Text(
        "Price",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
    );
  }
}
