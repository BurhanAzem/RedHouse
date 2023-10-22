import 'package:flutter/material.dart';

class PropertyType extends StatefulWidget {
  const PropertyType({Key? key}) : super(key: key);

  @override
  _PropertyTypeState createState() => _PropertyTypeState();
}

class _PropertyTypeState extends State<PropertyType> {
  bool apartmentChecked = true;
  bool singleHomeChecked = true;
  bool condoChecked = true;
  bool townHomeChecked = true;
  bool farmChecked = true;
  bool seeHomesButtonClicked = false; // New variable to track button click

  String selectedPropertyTypes = "Property type";

  void checkAllCheckboxes() {
    apartmentChecked = true;
    singleHomeChecked = true;
    condoChecked = true;
    townHomeChecked = true;
    farmChecked = true;
  }

  String getSelectedPropertyTypes() {
    List<String> selectedTypes = [];
    if (apartmentChecked) {
      selectedTypes.add('Apartment');
    }
    if (singleHomeChecked) {
      selectedTypes.add('Single family home');
    }
    if (condoChecked) {
      selectedTypes.add('Condo');
    }
    if (townHomeChecked) {
      selectedTypes.add('Townhome');
    }
    if (farmChecked) {
      selectedTypes.add('Farm');
    }
    return selectedTypes.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                apartmentChecked = !apartmentChecked;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: apartmentChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      apartmentChecked = value!;
                                    });
                                  },
                                  activeColor: Color.fromARGB(255, 12, 173, 18),
                                ),
                                const Text(
                                  'Apartment',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                singleHomeChecked = !singleHomeChecked;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: singleHomeChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      singleHomeChecked = value!;
                                    });
                                  },
                                  activeColor: Color.fromARGB(255, 12, 173, 18),
                                ),
                                const Text(
                                  'Single family home',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                condoChecked = !condoChecked;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: condoChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      condoChecked = value!;
                                    });
                                  },
                                  activeColor: Color.fromARGB(255, 12, 173, 18),
                                ),
                                const Text(
                                  'Condo',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                townHomeChecked = !townHomeChecked;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: townHomeChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      townHomeChecked = value!;
                                    });
                                  },
                                  activeColor: Color.fromARGB(255, 12, 173, 18),
                                ),
                                const Text(
                                  'Townhome',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                farmChecked = !farmChecked;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: farmChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      farmChecked = value!;
                                    });
                                  },
                                  activeColor: Color.fromARGB(255, 12, 173, 18),
                                ),
                                const Text(
                                  'Farm',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(height: 15),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          if (!apartmentChecked &&
                              !singleHomeChecked &&
                              !condoChecked &&
                              !townHomeChecked &&
                              !farmChecked) {
                            // If no checkboxes are selected, check all
                            checkAllCheckboxes();
                          }
                          setState(() {
                            selectedPropertyTypes = getSelectedPropertyTypes();
                            seeHomesButtonClicked = true;
                          });
                          print(selectedPropertyTypes);
                          Navigator.pop(context);
                        },
                        minWidth: 300,
                        height: 45,
                        color: Colors.black87,
                        child: Center(
                          child: Text(
                            "See 0 homes",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ).whenComplete(() {
          setState(() {});
        });
      },
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(
          color: Colors.grey,
          width: seeHomesButtonClicked ? 0 : 1.6,
        ),
      ),
      child: Container(
        width: 121,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            selectedPropertyTypes,
            style: TextStyle(
              color: seeHomesButtonClicked ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      color: seeHomesButtonClicked ? Colors.black : Colors.white,
    );
  }
}
