// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeContentModel _$HomeContentModelFromJson(Map<String, dynamic> json) =>
    HomeContentModel(
      userName: json['user_name'] as String,
      userLocation: json['user_location'] as String,
      banners: (json['banners'] as List<dynamic>)
          .map((e) => HomeBannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => HomeCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mostViewed: (json['most_viewed'] as List<dynamic>)
          .map((e) => BusinessModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentlyAdded: (json['recently_added'] as List<dynamic>)
          .map((e) => BusinessModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      medical: (json['medical'] as List<dynamic>)
          .map((e) => BusinessModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      restaurants: (json['restaurants'] as List<dynamic>)
          .map((e) => BusinessModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      advertisement: json['advertisement'] == null
          ? null
          : HomeAdvertisementModel.fromJson(
              json['advertisement'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$HomeContentModelToJson(HomeContentModel instance) =>
    <String, dynamic>{
      'user_name': instance.userName,
      'user_location': instance.userLocation,
      'banners': instance.banners,
      'categories': instance.categories,
      'most_viewed': instance.mostViewed,
      'recently_added': instance.recentlyAdded,
      'medical': instance.medical,
      'restaurants': instance.restaurants,
      'advertisement': instance.advertisement,
    };
