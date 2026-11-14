import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/offer_seller.dart';

part 'offer_seller_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OfferSellerModel {
  const OfferSellerModel({
    required this.id,
    required this.name,
    @JsonKey(name: 'is_verified', defaultValue: false) this.isVerified = false,
    this.location,
    this.memberSince,
    this.phone,
  });

  factory OfferSellerModel.fromJson(Map<String, dynamic> json) {
    return _$OfferSellerModelFromJson(json);
  }

  final String id;
  final String name;
  final bool isVerified;
  final String? location;
  final String? memberSince;
  final String? phone;

  Map<String, dynamic> toJson() => _$OfferSellerModelToJson(this);

  OfferSeller toEntity() {
    return OfferSeller(
      id: id,
      name: name,
      isVerified: isVerified,
      location: location,
      memberSince: memberSince,
      phone: phone,
    );
  }
}
