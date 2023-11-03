// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_files.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyFile _$PropertyFileFromJson(Map<String, dynamic> json) => PropertyFile(
      Id: json['id'] as int?,
      PropertyId: json['propertyId'] as int?,
      DownloadUrls: json['downloadUrls'] as String?,
    );

Map<String, dynamic> _$PropertyFileToJson(PropertyFile instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'PropertyId': instance.PropertyId,
      'DownloadUrls': instance.DownloadUrls,
    };
