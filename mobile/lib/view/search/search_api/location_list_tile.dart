import 'package:flutter/material.dart';

class LocationListTile extends StatefulWidget {
  final String location;
  final VoidCallback press;

  LocationListTile({Key? key, required this.location, required this.press})
      : super(key: key);

  @override
  State<LocationListTile> createState() => _LocationListTileState();
}

class _LocationListTileState extends State<LocationListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: widget.press,
          horizontalTitleGap: 10,
          leading: Icon(Icons.location_on),
          title: Text(
            widget.location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(height: 2, thickness: 1, color: Colors.grey[300]),
      ],
    );
  }
}
