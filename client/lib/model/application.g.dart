// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Application _$ApplicationFromJson(Map<String, dynamic> json) => Application(
      Id: json['id'] as int,
      PropertyId: json['propertyId'] as int,
      UserId: json['userId'] as int,
      ApplicationDate: DateTime.parse(json['applicationDate'] as String),
      ApplicationStatus: json['applicationStatus'] as String,
      Message: json['message'] as String,
      ApplicationType: json['applicationType'] as String,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
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
      'user': instance.user,
      'property': instance.property,
    };
