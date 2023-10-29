import 'package:client/view/bottom_bar/search/filter/filters_listview.dart';
import 'package:client/view/bottom_bar/search/map_widget.dart';
import 'package:client/view/bottom_bar/search/search_bar.dart';
import 'package:client/view/bottom_bar/search/sort_options.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _isListIcon = true;
  int resultsCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  SearchBarRow(
                    isListIcons: _isListIcon,
                    onToggleView: () {
                      setState(() {
                        _isListIcon = !_isListIcon;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: const FilterListView(),
            ),
            SortOptionsWidget(
              isListIcon: _isListIcon,
              resultsCount: resultsCount,
            ),
            Visibility(
              visible: _isListIcon,
              child: const Expanded(
                child: MapWidget(),
              ),
            ),
            Visibility(
              visible: !_isListIcon,
              child: const Column(children: [
                Divider(thickness: 1.0, color: Colors.black26),
                Text("List"),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
