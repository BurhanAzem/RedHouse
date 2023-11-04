import 'package:json_annotation/json_annotation.dart';

part "user.g.dart";

@JsonSerializable()
class User {
  int Id;
  String? Name;
  String? Email;
  bool IsVerified;
  int PhoneNumber;
  int LocationId;
  String? UserRole;

  User({
    required this.Id,
    required this.Email,
    required this.IsVerified,
    required this.LocationId,
    required this.Name,
    required this.PhoneNumber,
    required this.UserRole,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
