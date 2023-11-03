import 'package:client/model/property.dart';
import 'package:client/view/bottom_bar/search/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapListController extends GetxController {
  CameraPosition? currentPosition;
  RxString currentLocationName = "".obs;
  double? newZoom;
  BuildContext? mapContext;
  //___________________________________________________
  List<MapMarker> allMarkers = [];
  Set<Marker> visibleMarkers = <Marker>{};
  Set<Property> visibleProperties = <Property>{};

  // List<Property> allProperties = [];
  // [
  //   Property(
  //     PropertyId: 1,
  //     PropertyType: "House",
  //     UserId: 1,
  //     PropertyFiles: [
  //       "assets/images/home1.jpg",
  //       "assets/images/redhouse2.png",
  //       "assets/images/home2.jpg",
  //       "assets/images/for-sale2.jpg",
  //     ],
  //     PropertyLocation: Location(
  //       StreetAddress: "123 Main St",
  //       City: "Exampleville",
  //       Region: "State",
  //       PostalCode: "12345",
  //       Country: "Jersulm",
  //       Latitude: 31.778463,
  //       Longitude: 35.222245,
  //     ),
  //     Price: 250000,
  //     NumberOfBedRooms: 3,
  //     NumberOfBathRooms: 2,
  //     SquareMeter: 190,
  //     PropertyDescription:
  //         "Cozy apartment with a great view.A beautiful house with a garden.A beautiful house with a garden.A beautiful house with a garden.",
  //     BuiltYear: DateTime(2000),
  //     View: "Scenic",
  //     AvailableOn: DateTime(2023, 11, 1),
  //     PropertyStatus: "For Rent",
  //     NumberOfUnits: 1,
  //     ParkingSpots: 2,
  //     ListingType: "Residential",
  //     IsAvailableBasement: "Yes",
  //     ListingBy: "John Doe",
  //   ),
  //   Property(
  //     PropertyId: 2,
  //     PropertyType: "Apartment",
  //     UserId: 2,
  //     PropertyFiles: [
  //       "assets/images/home1.jpg",
  //       "assets/images/home2.jpg",
  //       "assets/images/home1.jpg",
  //       "assets/images/for-sale2.jpg",
  //     ],
  //     PropertyLocation: Location(
  //       StreetAddress: "456 Elm St",
  //       City: "Sampletown",
  //       Region: "State",
  //       PostalCode: "54321",
  //       Country: "Jersulm",
  //       Latitude: 31.773293,
  //       Longitude: 35.2292983,
  //     ),
  //     Price: 1200,
  //     NumberOfBedRooms: 2,
  //     NumberOfBathRooms: 1,
  //     SquareMeter: 80.2,
  //     PropertyDescription:
  //         "Cozy apartment with a great view.A beautiful house with a garden.A beautiful house with a garden.A beautiful house with a garden.",
  //     BuiltYear: DateTime(2015),
  //     View: "City",
  //     AvailableOn: DateTime(2023, 12, 1),
  //     PropertyStatus: "For Rent",
  //     NumberOfUnits: 1,
  //     ParkingSpots: 1,
  //     ListingType: "Residential",
  //     IsAvailableBasement: "No",
  //     ListingBy: "Jane Smith",
  //   ),
  //   Property(
  //     PropertyId: 3,
  //     PropertyType: "Condo",
  //     UserId: 3,
  //     PropertyFiles: [
  //       "assets/images/home1.jpg",
  //       "assets/images/redhouse2.png",
  //       "assets/images/for-sale2.jpg",
  //       "assets/images/home1.jpg",
  //       "assets/images/for-sale2.jpg",
  //     ],
  //     PropertyLocation: Location(
  //       StreetAddress: "789 Oak St",
  //       City: "Exampleshire",
  //       Region: "State",
  //       PostalCode: "98765",
  //       Country: "Jersulm",
  //       Latitude: 31.772398,
  //       Longitude: 35.22290,
  //     ),
  //     Price: 180000,
  //     NumberOfBedRooms: 2,
  //     NumberOfBathRooms: 2,
  //     SquareMeter: 100.0,
  //     PropertyDescription:
  //         "Cozy apartment with a great view.A beautiful house with a garden.A beautiful house with a garden.A beautiful house with a garden.",
  //     BuiltYear: DateTime(2010),
  //     View: "Park",
  //     AvailableOn: DateTime(2024, 1, 1),
  //     PropertyStatus: "For Rent",
  //     NumberOfUnits: 1,
  //     ParkingSpots: 1,
  //     ListingType: "Residential",
  //     IsAvailableBasement: "No",
  //     ListingBy: "Mike Johnson",
  //   ),
  //   Property(
  //     PropertyId: 4,
  //     PropertyType: "Villa",
  //     UserId: 4,
  //     PropertyFiles: [
  //       "assets/images/home2.jpg",
  //       "assets/images/for-rent.jpg",
  //       "assets/images/home1.jpg",
  //       "assets/images/home2.jpg",
  //       "assets/images/for-sale2.jpg",
  //     ],
  //     PropertyLocation: Location(
  //       StreetAddress: "10 Paradise Blvd",
  //       City: "Luxuryville",
  //       Region: "State",
  //       PostalCode: "54321",
  //       Country: "Jersulm",
  //       Latitude: 31.773293,
  //       Longitude: 35.2239302,
  //     ),
  //     Price: 1000000,
  //     NumberOfBedRooms: 5,
  //     NumberOfBathRooms: 6,
  //     SquareMeter: 500.0,
  //     PropertyDescription:
  //         "Cozy apartment with a great view.A beautiful house with a garden.A beautiful house with a garden.A beautiful house with a garden.",
  //     BuiltYear: DateTime(2018),
  //     View: "Ocean",
  //     AvailableOn: DateTime(2023, 11, 15),
  //     PropertyStatus: "For Rent",
  //     NumberOfUnits: 1,
  //     ParkingSpots: 2,
  //     ListingType: "Residential",
  //     IsAvailableBasement: "Yes",
  //     ListingBy: "Elena Martinez",
  //   ),
  //   Property(
  //     PropertyId: 5,
  //     PropertyType: "Townhouse",
  //     UserId: 5,
  //     PropertyFiles: [
  //       "assets/images/home2.jpg",
  //       "assets/images/home2.jpg",
  //       "assets/images/home1.jpg",
  //       "assets/images/for-sale2.jpg",
  //     ],
  //     PropertyLocation: Location(
  //       StreetAddress: "789 Cherry Lane",
  //       City: "Townsville",
  //       Region: "State",
  //       PostalCode: "12345",
  //       Country: "Jersulm",
  //       Latitude: 31.773293,
  //       Longitude: 35.222982,
  //     ),
  //     Price: 1800,
  //     NumberOfBedRooms: 3,
  //     NumberOfBathRooms: 2,
  //     SquareMeter: 120.3,
  //     PropertyDescription:
  //         "Cozy apartment with a great view.A beautiful house with a garden.A beautiful house with a garden.A beautiful house with a garden.",
  //     BuiltYear: DateTime(2020),
  //     View: "City",
  //     AvailableOn: DateTime(2023, 12, 5),
  //     PropertyStatus: "For Rent",
  //     NumberOfUnits: 1,
  //     ParkingSpots: 1,
  //     ListingType: "Residential",
  //     IsAvailableBasement: "No",
  //     ListingBy: "David Brown",
  //   ),
  //   // here separet
  //   Property(
  //     PropertyId: 6,
  //     PropertyType: "House",
  //     UserId: 1,
  //     PropertyFiles: [
  //       "assets/images/home1.jpg",
  //       "assets/images/redhouse2.png",
  //       "assets/images/home2.jpg",
  //       "assets/images/for-sale2.jpg",
  //     ],
  //     PropertyLocation: Location(
  //       StreetAddress: "123 Main St",
  //       City: "Exampleville",
  //       Region: "State",
  //       PostalCode: "12345",
  //       Country: "Nablus",
  //       Latitude: 32.221202,
  //       Longitude: 35.23322,
  //     ),
  //     Price: 250000,
  //     NumberOfBedRooms: 3,
  //     NumberOfBathRooms: 2,
  //     SquareMeter: 190,
  //     PropertyDescription:
  //         "Cozy apartment with a great view.A beautiful house with a garden.A beautiful house with a garden.A beautiful house with a garden.",
  //     BuiltYear: DateTime(2000),
  //     View: "Scenic",
  //     AvailableOn: DateTime(2023, 11, 1),
  //     PropertyStatus: "For Rent",
  //     NumberOfUnits: 1,
  //     ParkingSpots: 2,
  //     ListingType: "Residential",
  //     IsAvailableBasement: "Yes",
  //     ListingBy: "John Doe",
  //   ),
  //   Property(
  //     PropertyId: 7,
  //     PropertyType: "Apartment",
  //     UserId: 2,
  //     PropertyFiles: [
  //       "assets/images/home1.jpg",
  //       "assets/images/home2.jpg",
  //       "assets/images/home1.jpg",
  //       "assets/images/for-sale2.jpg",
  //     ],
  //     PropertyLocation: Location(
  //       StreetAddress: "456 Elm St",
  //       City: "Sampletown",
  //       Region: "State",
  //       PostalCode: "54321",
  //       Country: "Nablus",
  //       Latitude: 32.22745,
  //       Longitude: 35.23983,
  //     ),
  //     Price: 1200,
  //     NumberOfBedRooms: 2,
  //     NumberOfBathRooms: 1,
  //     SquareMeter: 80.2,
  //     PropertyDescription:
  //         "Cozy apartment with a great view.A beautiful house with a garden.A beautiful house with a garden.A beautiful house with a garden.",
  //     BuiltYear: DateTime(2015),
  //     View: "City",
  //     AvailableOn: DateTime(2023, 12, 1),
  //     PropertyStatus: "For Rent",
  //     NumberOfUnits: 1,
  //     ParkingSpots: 1,
  //     ListingType: "Residential",
  //     IsAvailableBasement: "No",
  //     ListingBy: "Jane Smith",
  //   ),
  //   Property(
  //     PropertyId: 8,
  //     PropertyType: "Condo",
  //     UserId: 3,
  //     PropertyFiles: [
  //       "assets/images/home1.jpg",
  //       "assets/images/redhouse2.png",
  //       "assets/images/for-sale2.jpg",
  //       "assets/images/home1.jpg",
  //       "assets/images/for-sale2.jpg",
  //     ],
  //     PropertyLocation: Location(
  //       StreetAddress: "789 Oak St",
  //       City: "Exampleshire",
  //       Region: "State",
  //       PostalCode: "98765",
  //       Country: "Nablus",
  //       Latitude: 32.222092,
  //       Longitude: 35.23234,
  //     ),
  //     Price: 180000,
  //     NumberOfBedRooms: 2,
  //     NumberOfBathRooms: 2,
  //     SquareMeter: 100.0,
  //     PropertyDescription:
  //         "Cozy apartment with a great view.A beautiful house with a garden.A beautiful house with a garden.A beautiful house with a garden.",
  //     BuiltYear: DateTime(2010),
  //     View: "Park",
  //     AvailableOn: DateTime(2024, 1, 1),
  //     PropertyStatus: "For Rent",
  //     NumberOfUnits: 1,
  //     ParkingSpots: 1,
  //     ListingType: "Residential",
  //     IsAvailableBasement: "No",
  //     ListingBy: "Mike Johnson",
  //   ),
  //   Property(
  //     PropertyId: 9,
  //     PropertyType: "Townhouse",
  //     UserId: 5,
  //     PropertyFiles: [
  //       "assets/images/home2.jpg",
  //       "assets/images/home2.jpg",
  //       "assets/images/home1.jpg",
  //       "assets/images/for-sale2.jpg",
  //     ],
  //     PropertyLocation: Location(
  //       StreetAddress: "789 Cherry Lane",
  //       City: "Townsville",
  //       Region: "State",
  //       PostalCode: "12345",
  //       Country: "Nablus",
  //       Latitude: 32.22998,
  //       Longitude: 35.239843,
  //     ),
  //     Price: 1800,
  //     NumberOfBedRooms: 3,
  //     NumberOfBathRooms: 2,
  //     SquareMeter: 120.3,
  //     PropertyDescription:
  //         "Cozy apartment with a great view.A beautiful house with a garden.A beautiful house with a garden.A beautiful house with a garden.",
  //     BuiltYear: DateTime(2020),
  //     View: "City",
  //     AvailableOn: DateTime(2023, 12, 5),
  //     PropertyStatus: "For Rent",
  //     NumberOfUnits: 1,
  //     ParkingSpots: 1,
  //     ListingType: "Residential",
  //     IsAvailableBasement: "No",
  //     ListingBy: "David Brown",
  //   ),
  // ];
}
