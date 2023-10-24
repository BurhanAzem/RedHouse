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
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // SearchDelegate
              showSearch(context: context, delegate: HomeSearch());
            },
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  Container(
                    width: 77,
                    child: GestureDetector(
                      onTap: () {
                        widget.onToggleView();
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              widget.isListIcons ? "List " : "Map",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(
                            widget.isListIcons
                                ? Icons.format_list_bulleted
                                : Icons.map_outlined,
                            color: Colors.black,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text("   "),
                  Container(
                    width: 230,
                    child: Text("City, ZIP, School, Address",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                        ),
                        overflow: TextOverflow.ellipsis),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.search_outlined,
                          size: 27,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
