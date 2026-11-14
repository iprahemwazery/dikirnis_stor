// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessModel _$BusinessModelFromJson(Map<String, dynamic> json) =>
    BusinessModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      views: (json['views'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      rank: (json['rank'] as num?)?.toInt(),
      isNew: json['is_new'] as bool? ?? false,
      isVerified: json['is_verified'] as bool? ?? false,
      isSponsored: json['is_sponsored'] as bool? ?? false,
    );

Map<String, dynamic> _$BusinessModelToJson(BusinessModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'image': instance.image,
      'rating': instance.rating,
      'views': instance.views,
      'description': instance.description,
      'rank': instance.rank,
      'is_new': instance.isNew,
      'is_verified': instance.isVerified,
      'is_sponsored': instance.isSponsored,
    };
