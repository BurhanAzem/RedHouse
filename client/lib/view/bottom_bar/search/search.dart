import 'package:client/view/bottom_bar/search/filter/filters_listview.dart';
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
              padding: EdgeInsets.only(top: 40, left: 22, right: 22),
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
            Container(height: 15),
            FilterListView(),
            Container(height: 7),
            SortOptionsWidget(
              isListIcon: _isListIcon,
              resultsCount: resultsCount,
            ),
            Divider(thickness: 1.0, color: Colors.black26),
            Visibility(
                visible: _isListIcon, child: Container(child: Text("x"))),
            Visibility(
                visible: !_isListIcon, child: Container(child: Text("List"))),
          ],
        ),
      ),
    );
  }
}
