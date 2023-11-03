// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Application _$ApplicationFromJson(Map<String, dynamic> json) => Application(
      Id: json['Id'] as int,
      PropertyId: json['PropertyId'] as int,
      UserId: json['UserId'] as int,
      ApplicationDate: DateTime.parse(json['ApplicationDate'] as String),
      ApplicationStatus: json['ApplicationStatus'] as String,
      Message: json['Message'] as String,
      ApplicationType: json['ApplicationType'] as String,
    );

Map<String, dynamic> _$ApplicationToJson(Application instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'PropertyId': instance.PropertyId,
      'UserId': instance.UserId,
      'ApplicationDate': instance.ApplicationDate.toIso8601String(),
      'ApplicationStatus': instance.ApplicationStatus,
      'Message': instance.Message,
      'ApplicationType': instance.ApplicationType,
    };
