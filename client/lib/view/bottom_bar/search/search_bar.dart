import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchBarRow extends StatefulWidget {
  final bool isListIcons;
  final VoidCallback onToggleView;

  const SearchBarRow({
    Key? key,
    required this.isListIcons,
    required this.onToggleView,
  }) : super(key: key);

  @override
  State<SearchBarRow> createState() => _SearchBarRowState();
}

class _SearchBarRowState extends State<SearchBarRow> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // SearchDelegate
              showSearch(context: context, delegate: HomeSearch());
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
                    child: Text("City, ZIP, School, AddressAddress",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black45,
                        ),
                        overflow: TextOverflow.ellipsis),
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
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      widget.isListIcons
                          ? Icons.format_list_bulleted
                          : Icons.map_outlined,
                      color: Colors.black,
                      size: widget.isListIcons ? 27 : 28,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Text(
                      widget.isListIcons ? "List" : "Map",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.isListIcons ? 20 : 18,
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

class HomeSearch extends SearchDelegate {
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<void> startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      await _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            // Set the recognized text as the query
            query = result.recognizedWords;
          }
        },
      );
    } else {
      // Handle if speech recognition is not available
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query == "")
        IconButton(
          onPressed: () {
            startListening();
            print("===================================================");
            print(query);
          },
          icon: Icon(Icons.keyboard_voice, size: 30, color: Colors.black),
        )
      else
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close, size: 27, color: Colors.black),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back, size: 27, color: Colors.black));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("voiceQuery: $query");
  }
}
