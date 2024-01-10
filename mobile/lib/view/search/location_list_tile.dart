import 'package:client/controller/map_list/map_list_controller.dart';
import 'package:client/model/location.dart';
import 'package:client/view/bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationListTile extends StatefulWidget {
  final Location location;

  const LocationListTile({Key? key, required this.location}) : super(key: key);

  @override
  State<LocationListTile> createState() => _LocationListTileState();
}

class _LocationListTileState extends State<LocationListTile> {
  MapListController mapListController = Get.put(MapListController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            LatLng centerCoordinates =
                LatLng(widget.location.latitude, widget.location.longitude);
            print(centerCoordinates);

            setState(() {
              mapListController.currentPosition = CameraPosition(
                target: centerCoordinates,
                zoom: 10,
              );
            });

            Get.to(() => const BottomBar());
            setState(() {});
          },
          horizontalTitleGap: 10,
          leading: const Icon(Icons.location_on),
          title: Text(
            '${widget.location.country}, ${widget.location.city}, ${widget.location.streetAddress}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(height: 2, thickness: 1, color: Colors.grey[300]),
      ],
    );
  }
}
