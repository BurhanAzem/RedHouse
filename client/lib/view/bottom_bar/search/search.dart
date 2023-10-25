import 'dart:async';

import 'package:client/view/bottom_bar/search/filter/filters_listview.dart';
import 'package:client/view/bottom_bar/search/search_bar.dart';
import 'package:client/view/bottom_bar/search/sort_options.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  GoogleMapController? mapController;

  CameraPosition jerusalem = CameraPosition(
    target: LatLng(32.438909, 35.295625),
    zoom: 8,
  );

  bool _isListIcon = true;
  int resultsCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40),
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
              margin: EdgeInsets.symmetric(vertical: 15),
              child: FilterListView(),
            ),
            SortOptionsWidget(
              isListIcon: _isListIcon,
              resultsCount: resultsCount,
            ),
            Visibility(
              visible: _isListIcon,
              child: Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: jerusalem,
                  onMapCreated: (mapcontroller) {
                    mapController = mapController;
                  },
                ),
              ),
            ),
            Visibility(
              visible: !_isListIcon,
              child: Column(children: [
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
