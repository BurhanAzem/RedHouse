import 'package:flutter/material.dart';

class SortOptionsWidget extends StatefulWidget {
  final bool isListIcon;
  final int resultsCount;

  SortOptionsWidget({
    required this.isListIcon,
    required this.resultsCount,
  });

  @override
  _SortOptionsWidgetState createState() => _SortOptionsWidgetState();
}

class _SortOptionsWidgetState extends State<SortOptionsWidget> {
  int _temporaryValue = 1;
  int _selectedValue = 1;
  String _selectedText = "Default";

  String getSelectedText(int selectedValue) {
    switch (selectedValue) {
      case 1:
        return "Default";
      case 2:
        return "Lowest price";
      case 3:
        return "Highest price";
      default:
        return "Default";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: widget.isListIcon ? 0.0 : 35,
      child: Visibility(
        visible: !widget.isListIcon,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " ${widget.resultsCount} results",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30)),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  height:
                                      MediaQuery.of(context).size.height / 2.24,
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              const Text(
                                                'Sort by  ',
                                                style: TextStyle(
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ],
                                          ),
                                          RadioListTile<int>(
                                            value: 1,
                                            groupValue: _temporaryValue,
                                            title: Text("Default"),
                                            onChanged: (value) {
                                              setState(() {
                                                _temporaryValue = value!;
                                              });
                                            },
                                            activeColor: Colors.green,
                                          ),
                                          RadioListTile<int>(
                                            value: 2,
                                            groupValue: _temporaryValue,
                                            title: Text("Lowest price"),
                                            onChanged: (value) {
                                              setState(() {
                                                _temporaryValue = value!;
                                              });
                                            },
                                            activeColor: Colors.green,
                                          ),
                                          RadioListTile<int>(
                                            value: 3,
                                            groupValue: _temporaryValue,
                                            title: Text("Highest price"),
                                            onChanged: (value) {
                                              setState(() {
                                                _temporaryValue = value!;
                                              });
                                            },
                                            activeColor: Colors.green,
                                          ),
                                        ],
                                      ),
                                      Container(height: 15),
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _selectedValue = _temporaryValue;
                                            _selectedText = getSelectedText(
                                                _temporaryValue);
                                          });
                                          Navigator.pop(context);
                                        },
                                        minWidth: 300,
                                        height: 45,
                                        color: Colors.black87,
                                        child: const Text(
                                          "Apply",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ).whenComplete(() {
                          setState(() {
                            _temporaryValue = _selectedValue;
                          });
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "$_selectedText",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
