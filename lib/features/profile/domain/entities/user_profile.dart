import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.name,
    required this.location,
    required this.memberSince,
    required this.ordersCount,
    required this.favoritesCount,
    required this.reviewsCount,
  });

  final String name;
  final String location;
  final String memberSince;
  final int ordersCount;
  final int favoritesCount;
  final int reviewsCount;

  @override
  List<Object?> get props => [
    name,
    location,
    memberSince,
    ordersCount,
    favoritesCount,
    reviewsCount,
  ];
}
