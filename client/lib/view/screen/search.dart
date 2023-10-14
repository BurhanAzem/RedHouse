import 'package:flutter/material.dart';


class Search extends StatelessWidget {
  const Search({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        // Updated to primarySwatch for specifying primary color
        // useMaterial3: true, // This line is not necessary
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), label: "Contract"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Notification"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Manage Propireties"),
            BottomNavigationBarItem(icon: Icon(Icons.more), label: "More"),
          ],
        ),
        appBar: AppBar(
          title: Text("RedHouse"), // Removed const from Text widget
          backgroundColor: Colors.red,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                          fillColor: Colors.grey[350],
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Icon(
                      Icons.menu,
                      size: 35,
                    ),
                  )
                ],
              ),
              Container(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(Search());
}
