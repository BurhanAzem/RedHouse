import 'package:client/controller/bottom_bar/filter_controller.dart';
import 'package:client/controller/map_list/map_list_controller.dart';
import 'package:client/view/filter/buy_filter.dart';
import 'package:client/view/filter/rent_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Price extends StatefulWidget {
  Price({Key? key}) : super(key: key);

  @override
  _PriceState createState() => _PriceState();
}

class _PriceState extends State<Price> {
  MapListController mapListController = Get.put(MapListController());
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(
      init: FilterController(),
      builder: (controller) => MaterialButton(
        onPressed: () {
          controller.buyMaxControllerTemp.text =
              controller.buyMaxController.text;
          controller.buyMinControllerTemp.text =
              controller.buyMinController.text;
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
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
                              const RowRentPrice(),
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
                                    controller.buyMaxControllerTemp.text !=
                                        "" &&
                                    int.parse(controller
                                            .buyMinControllerTemp.text) >
                                        int.parse(controller
                                            .buyMaxControllerTemp.text)) {
                                  Get.rawSnackbar(
                                    snackPosition: SnackPosition.TOP,
                                    messageText: const Text(
                                      'The Min limit cannot be greater than the Max limit',
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
                                  controller.rentMaxController.text = "";
                                  controller.rentMinController.text = "";
                                  controller.buyMaxController.text =
                                      controller.buyMaxControllerTemp.text;
                                  controller.buyMinController.text =
                                      controller.buyMinControllerTemp.text;

                                  controller.formatPriceRange(
                                      controller.buyMinController,
                                      controller.buyMaxController);

                                  controller.getProperties();

                                  Navigator.pop(context);
                                }
                              } else {
                                if (controller.rentMinControllerTemp.text != "" &&
                                    controller.rentMaxControllerTemp.text !=
                                        "" &&
                                    int.parse(controller
                                            .rentMinControllerTemp.text) >
                                        int.parse(controller
                                            .rentMaxControllerTemp.text)) {
                                  Get.rawSnackbar(
                                    snackPosition: SnackPosition.TOP,
                                    messageText: const Text(
                                      'The Min limit cannot be greater than the Max limit',
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
                                  controller.buyMaxController.text = "";
                                  controller.buyMinController.text = "";
                                  controller.rentMaxController.text =
                                      controller.rentMaxControllerTemp.text;
                                  controller.rentMinController.text =
                                      controller.rentMinControllerTemp.text;

                                  controller.formatPriceRange(
                                      controller.rentMinController,
                                      controller.rentMaxController);

                                  controller.checkFiltersON();

                                  controller.getProperties();
                                  mapListController.isLoading = true;
                                  Navigator.pop(context);
                                }
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
          side: BorderSide(
            color: Colors.grey,
            width: controller.priceON ? 0 : 1.5,
          ),
        ),
        color: controller.priceON ? Colors.black : Colors.white,
        child: Text(
          controller.priceText,
          style: TextStyle(
            color: controller.priceON ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
