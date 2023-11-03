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

  Application(
      {required this.Id,
      required this.PropertyId,
      required this.UserId,
      required this.ApplicationDate,
      required this.ApplicationStatus,
      required this.Message,
      required this.ApplicationType,
      });

  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationToJson(this);
}
