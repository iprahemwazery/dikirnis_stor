import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/home_advertisement.dart';

part 'home_advertisement_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HomeAdvertisementModel {
  const HomeAdvertisementModel({
    required this.id,
    required this.advertiserName,
    required this.description,
    required this.logoIconKey,
  });

  factory HomeAdvertisementModel.fromJson(Map<String, dynamic> json) {
    return _$HomeAdvertisementModelFromJson(json);
  }

  final String id;
  final String advertiserName;
  final String description;
  final String logoIconKey;

  Map<String, dynamic> toJson() => _$HomeAdvertisementModelToJson(this);

  HomeAdvertisement toEntity() {
    return HomeAdvertisement(
      id: id,
      advertiserName: advertiserName,
      description: description,
      logoIconKey: logoIconKey,
    );
  }
}
