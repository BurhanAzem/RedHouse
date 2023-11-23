import 'package:client/controller/map_list_controller.dart';
import 'package:client/view/search/search_api/search_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarRow extends StatefulWidget {
  final VoidCallback onToggleView;

  const SearchBarRow({
    Key? key,
    required this.onToggleView,
  }) : super(key: key);

  @override
  State<SearchBarRow> createState() => _SearchBarRowState();
}

class _SearchBarRowState extends State<SearchBarRow> {
  MapListController controller = Get.put(MapListController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => const SearhcLoactionScreen());
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(239, 239, 239, 10),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.search_outlined,
                        size: 26,
                      ),
                    ),
                  ),
                  Container(width: 15),
                  Container(
                    width: 210,
                    child: Obx(() {
                      return Text(
                        controller.currentLocationName.value == ""
                            ? "City, ZIP, School, AddressAddress"
                            : "Area in ${controller.currentLocationName.value}",
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black45,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    }),
                  ),
                  Container(width: 8),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.onToggleView();
            },
            child: Container(
              width: 82,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      controller.isListIcon
                          ? Icons.format_list_bulleted
                          : Icons.map_outlined,
                      color: Colors.black,
                      size: controller.isListIcon ? 27 : 28,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text(
                      controller.isListIcon ? "List" : "Map",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: controller.isListIcon ? 20 : 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
