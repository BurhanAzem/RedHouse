import 'package:client/view/search/search_api/location_list_tile.dart';
import 'package:client/view/search/search_api/network_utility.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearhcLoactionScreen extends StatefulWidget {
  const SearhcLoactionScreen({super.key});

  @override
  State<SearhcLoactionScreen> createState() => _SearhcLoactionScreenState();
}

class _SearhcLoactionScreenState extends State<SearhcLoactionScreen> {
  void placeAutocomplate(String query) async {
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": "AIzaSyCHqSp4_YvEXCpwvOpKmp65ElyNd5W85O4",
    });
    String? response = await NetowrkUtility.fetchUrl(uri);
    if (response != null) {
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "    Set House Location",
          style: TextStyle(color: Colors.black87, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          Form(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              onChanged: (value) {},
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Color.fromARGB(182, 239, 237, 237),
                filled: true,
                hintText: "Search your Location",
                hintStyle: TextStyle(color: Colors.black45),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Icon(Icons.share_location_outlined),
                ),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 17),
            child: ElevatedButton.icon(
              onPressed: () {
                placeAutocomplate("Dubai");
              },
              icon: const Icon(
                FontAwesomeIcons.locationArrow,
                size: 18.5,
                color: Colors.black54,
              ),
              label: const Text("Use my Current Location"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  elevation: 0,
                  fixedSize: const Size(365, 45),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Divider(height: 3, thickness: 1, color: Colors.grey[300]),
          Expanded(
            child: ListView(
              children: [
                LocationListTile(
                  press: () {},
                  location: "Gaza,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Jerusalem,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Nablus,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Jenin,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Ramallah,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Jericho,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Al-Bireh,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Tulkarm,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Hebron,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Bethlehem,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Khan Yunis,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Rafah,  Palestine",
                ),
                 LocationListTile(
                  press: () {},
                  location: "Qalqilya,  Palestine",
                ),
                 LocationListTile(
                  press: () {},
                  location: "Tubas,  Palestine",
                ),
                LocationListTile(
                  press: () {},
                  location: "Bayt Jala,  Palestine",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
