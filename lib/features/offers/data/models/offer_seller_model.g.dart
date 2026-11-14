// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_seller_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferSellerModel _$OfferSellerModelFromJson(Map<String, dynamic> json) =>
    OfferSellerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isVerified: json['is_verified'] as bool? ?? false,
      location: json['location'] as String?,
      memberSince: json['member_since'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$OfferSellerModelToJson(OfferSellerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_verified': instance.isVerified,
      'location': instance.location,
      'member_since': instance.memberSince,
      'phone': instance.phone,
    };
