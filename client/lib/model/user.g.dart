// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      Id: json['id'] as int,
      Email: json['email'] as String?,
      IsVerified: json['isVerified'] as bool,
      LocationId: json['locationId'] as int,
      Name: json['name'] as String?,
      PhoneNumber: json['phoneNumber'] as int,
      UserRole: json['userRole'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'Id': instance.Id,
      'Name': instance.Name,
      'Email': instance.Email,
      'IsVerified': instance.IsVerified,
      'PhoneNumber': instance.PhoneNumber,
      'LocationId': instance.LocationId,
      'UserRole': instance.UserRole,
    };
