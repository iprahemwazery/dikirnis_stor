import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_profile.dart';

part 'profile_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileModel {
  const ProfileModel({
    required this.name,
    required this.location,
    required this.memberSince,
    required this.ordersCount,
    required this.favoritesCount,
    required this.reviewsCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return _$ProfileModelFromJson(json);
  }

  final String name;
  final String location;
  final String memberSince;
  final int ordersCount;
  final int favoritesCount;
  final int reviewsCount;

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  UserProfile toEntity() {
    return UserProfile(
      name: name,
      location: location,
      memberSince: memberSince,
      ordersCount: ordersCount,
      favoritesCount: favoritesCount,
      reviewsCount: reviewsCount,
    );
  }
}
