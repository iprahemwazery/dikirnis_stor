import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/business.dart';

part 'business_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BusinessModel {
  const BusinessModel({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.rating,
    @JsonKey(defaultValue: 0) this.views = 0,
    this.description,
    this.rank,
    @JsonKey(name: 'is_new', defaultValue: false) this.isNew = false,
    @JsonKey(name: 'is_verified', defaultValue: false) this.isVerified = false,
    @JsonKey(name: 'is_sponsored', defaultValue: false)
    this.isSponsored = false,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return _$BusinessModelFromJson(json);
  }

  final String id;
  final String name;
  final String location;
  final String image;
  final double rating;
  final int views;
  final String? description;
  final int? rank;
  final bool isNew;
  final bool isVerified;
  final bool isSponsored;

  Map<String, dynamic> toJson() => _$BusinessModelToJson(this);

  Business toEntity() {
    return Business(
      id: id,
      name: name,
      location: location,
      image: image,
      rating: rating,
      views: views,
      description: description,
      rank: rank,
      isNew: isNew,
      isVerified: isVerified,
      isSponsored: isSponsored,
    );
  }
}
