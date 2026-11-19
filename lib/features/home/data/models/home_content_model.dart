import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/home_content.dart';
import 'business_model.dart';
import 'home_advertisement_model.dart';
import 'home_banner_model.dart';
import 'home_category_model.dart';

part 'home_content_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HomeContentModel {
  const HomeContentModel({
    required this.userName,
    required this.userLocation,
    required this.banners,
    required this.categories,
    required this.mostViewed,
    required this.recentlyAdded,
    required this.medical,
    required this.restaurants,
    this.businesses = const {},
    this.advertisement,
  });

  factory HomeContentModel.fromJson(Map<String, dynamic> json) {
    return _$HomeContentModelFromJson(json);
  }

  final String userName;
  final String userLocation;
  final List<HomeBannerModel> banners;
  final List<HomeCategoryModel> categories;
  final List<BusinessModel> mostViewed;
  final List<BusinessModel> recentlyAdded;
  final List<BusinessModel> medical;
  final List<BusinessModel> restaurants;
  @JsonKey(defaultValue: <String, List<BusinessModel>>{})
  final Map<String, List<BusinessModel>> businesses;
  final HomeAdvertisementModel? advertisement;

  Map<String, dynamic> toJson() => _$HomeContentModelToJson(this);

  HomeContent toEntity() {
    return HomeContent(
      userName: userName,
      userLocation: userLocation,
      banners: banners
          .map((banner) => banner.toEntity())
          .toList(growable: false),
      categories: categories
          .map((category) => category.toEntity())
          .toList(growable: false),
      mostViewed: mostViewed
          .map((business) => business.toEntity())
          .toList(growable: false),
      recentlyAdded: recentlyAdded
          .map((business) => business.toEntity())
          .toList(growable: false),
      medical: medical
          .map((business) => business.toEntity())
          .toList(growable: false),
      restaurants: restaurants
          .map((business) => business.toEntity())
          .toList(growable: false),
      businesses: businesses.map(
        (categoryId, items) => MapEntry(
          categoryId,
          items.map((business) => business.toEntity()).toList(growable: false),
        ),
      ),
      advertisement: advertisement?.toEntity(),
    );
  }
}
