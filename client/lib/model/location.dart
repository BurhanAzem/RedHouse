// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part "location.g.dart";

@JsonSerializable()
class Location {
  int Id;
  String StreetAddress;
  String City;
  String Region;
  String PostalCode;
  String Country;
  double Latitude;
  double Longitude;

  Location({
    required this.Id,
    required this.StreetAddress,
    required this.City,
    required this.Region,
    required this.PostalCode,
    required this.Country,
    required this.Latitude,
    required this.Longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
  // factory Location.fromJson(Map<String, dynamic> json) {
  //   return Location(
  //     StreetAddress: json['StreetAddress'],
  //     City: json['City'],
  //     Region: json['Region'],
  //     PostalCode: json['PostalCode'],
  //     Country: json['Country'],
  //     Latitude: json['Latitude']?.toDouble(),
  //     Longitude: json['Longitude']?.toDouble(),
  //   );
  // }
}
