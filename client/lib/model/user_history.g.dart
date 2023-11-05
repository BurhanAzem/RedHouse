// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHistory _$UserHistoryFromJson(Map<String, dynamic> json) => UserHistory(
      id: json['id'] as int,
      customerId: json['customerId'] as int,
      landlordId: json['landlordId'] as int,
      timeStamp: DateTime.parse(json['timeStamp'] as String),
      comment: json['comment'] as String,
      rating: json['rating'] as int,
    );

Map<String, dynamic> _$UserHistoryToJson(UserHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'landlordId': instance.landlordId,
      'timeStamp': instance.timeStamp.toIso8601String(),
      'comment': instance.comment,
      'rating': instance.rating,
    };
