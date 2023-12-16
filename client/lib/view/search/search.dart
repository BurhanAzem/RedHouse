import 'package:client/controller/map_list/map_list_controller.dart';
import 'package:client/view/filter/filters_listview.dart';
import 'package:client/view/search/list_widget.dart';
import 'package:client/view/search/map_widget.dart';
import 'package:client/view/search/search_bar.dart';
import 'package:client/view/search/sort_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int resultsCount = 0;
  MapListController controller = Get.put(MapListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //
          Container(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                SearchBarRow(
                  onToggleView: () {
                    setState(() {
                      controller.isListIcon = !controller.isListIcon;
                    });
                  },
                ),
              ],
            ),
          ),

          //
          if (controller.isListIcon)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: const FilterListView(),
            ),

          //
          SortOptionsWidget(
            isListIcon: controller.isListIcon,
            resultsCount: resultsCount,
          ),

          //
          if (controller.isListIcon)
            const Expanded(child: MapWidget())   
          else
            Expanded(
              child: ListWidget(properties: controller.visibleProperties),
            ),
        ],
      ),
    );
  }
}
