// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBannerModel _$HomeBannerModelFromJson(Map<String, dynamic> json) =>
    HomeBannerModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$HomeBannerModelToJson(HomeBannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'image': instance.image,
    };
