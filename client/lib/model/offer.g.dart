// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      id: json['id'] as int,
      contractId: json['contractId'] as int,
      offerDate: DateTime.parse(json['offerDate'] as String),
      offerExpires: DateTime.parse(json['offerExpires'] as String),
      description: json['description'] as String,
      offerStatus: json['offerStatus'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'contractId': instance.contractId,
      'offerDate': instance.offerDate.toIso8601String(),
      'offerExpires': instance.offerExpires.toIso8601String(),
      'description': instance.description,
      'price': instance.price,
      'offerStatus': instance.offerStatus,
    };
