// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_advertisement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeAdvertisementModel _$HomeAdvertisementModelFromJson(
  Map<String, dynamic> json,
) => HomeAdvertisementModel(
  id: json['id'] as String,
  advertiserName: json['advertiser_name'] as String,
  description: json['description'] as String,
  logoIconKey: json['logo_icon_key'] as String,
);

Map<String, dynamic> _$HomeAdvertisementModelToJson(
  HomeAdvertisementModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'advertiser_name': instance.advertiserName,
  'description': instance.description,
  'logo_icon_key': instance.logoIconKey,
};
