import 'package:client/model/property.dart';
import 'package:client/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part "application.g.dart";

@JsonSerializable()
class Application {
  int Id;
  int PropertyId;
  int UserId;
  DateTime ApplicationDate;
  String ApplicationStatus;
  String Message;
  String ApplicationType;
  User user;
  Property property;
  Application(
      {required this.Id,
      required this.PropertyId,
      required this.UserId,
      required this.ApplicationDate,
      required this.ApplicationStatus,
      required this.Message,
      required this.ApplicationType,
      required this.property,
      required this.user,
      });

  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationToJson(this);
}
