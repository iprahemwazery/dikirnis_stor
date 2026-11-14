import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/home_banner.dart';

part 'home_banner_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HomeBannerModel {
  const HomeBannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) {
    return _$HomeBannerModelFromJson(json);
  }

  final String id;
  final String title;
  final String subtitle;
  final String image;

  Map<String, dynamic> toJson() => _$HomeBannerModelToJson(this);

  HomeBanner toEntity() {
    return HomeBanner(id: id, title: title, subtitle: subtitle, image: image);
  }
}
