import 'package:equatable/equatable.dart';

import 'business.dart';
import 'home_advertisement.dart';
import 'home_banner.dart';
import 'home_category.dart';

class HomeContent extends Equatable {
  const HomeContent({
    required this.userName,
    required this.userLocation,
    required this.banners,
    required this.categories,
    required this.mostViewed,
    required this.recentlyAdded,
    required this.medical,
    required this.restaurants,
    this.advertisement,
  });

  final String userName;
  final String userLocation;
  final List<HomeBanner> banners;
  final List<HomeCategory> categories;
  final List<Business> mostViewed;
  final List<Business> recentlyAdded;
  final List<Business> medical;
  final List<Business> restaurants;
  final HomeAdvertisement? advertisement;

  bool get isEmpty =>
      banners.isEmpty &&
      categories.isEmpty &&
      mostViewed.isEmpty &&
      recentlyAdded.isEmpty &&
      medical.isEmpty &&
      restaurants.isEmpty;

  @override
  List<Object?> get props => [
    userName,
    userLocation,
    banners,
    categories,
    mostViewed,
    recentlyAdded,
    medical,
    restaurants,
    advertisement,
  ];
}
