// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  name: json['name'] as String,
  location: json['location'] as String,
  memberSince: json['member_since'] as String,
  ordersCount: (json['orders_count'] as num).toInt(),
  favoritesCount: (json['favorites_count'] as num).toInt(),
  reviewsCount: (json['reviews_count'] as num).toInt(),
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'member_since': instance.memberSince,
      'orders_count': instance.ordersCount,
      'favorites_count': instance.favoritesCount,
      'reviews_count': instance.reviewsCount,
    };
