import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isListView = true;
  String buttonText = "List";
  IconData buttonIcon = Icons.list;

  void toggleView() {
    setState(() {
      isListView = !isListView;
      buttonText = isListView ? "List" : "Map";
      buttonIcon = isListView ? Icons.list : Icons.map_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 79,
                          child: GestureDetector(
                            onTap: () {
                              toggleView(); // Call the function to change the view
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    buttonText, // Display updated text
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Icon(
                                  buttonIcon, // Display updated icon
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showSearch(
                                context: context, delegate: HomeSearch());
                          },
                          child: Text(
                            "    City, Zip, School, or Addr",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ],
                    )),
                Text("e...   ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[400],
                    )),
                Icon(
                  Icons.search_outlined,
                  size: 27,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class HomeSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    throw UnimplementedError();
    
  }

  @override
  Widget? buildLeading(BuildContext context) {
    throw UnimplementedError();
    
  }
  
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}