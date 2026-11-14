import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/offer.dart';
import 'offer_comment_model.dart';
import 'offer_seller_model.dart';

part 'offer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OfferModel {
  const OfferModel({
    required this.id,
    required this.businessName,
    required this.title,
    required this.description,
    required this.image,
    required this.categoryId,
    required this.price,
    required this.seller,
    this.originalPrice,
    this.images = const [],
    this.discountPercent,
    this.expiresAt,
    this.publishedAt,
    @JsonKey(defaultValue: 0) this.views = 0,
    @JsonKey(name: 'is_featured', defaultValue: false) this.isFeatured = false,
    @JsonKey(name: 'is_available', defaultValue: true) this.isAvailable = true,
    this.comments = const [],
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return _$OfferModelFromJson(json);
  }

  final String id;
  final String businessName;
  final String title;
  final String description;
  final String image;
  final String categoryId;
  final double price;
  final double? originalPrice;
  final List<String> images;
  final OfferSellerModel seller;
  final int? discountPercent;
  final DateTime? expiresAt;
  final DateTime? publishedAt;
  final int views;
  final bool isFeatured;
  final bool isAvailable;
  final List<OfferCommentModel> comments;

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);

  Offer toEntity() {
    return Offer(
      id: id,
      businessName: businessName,
      title: title,
      description: description,
      image: image,
      categoryId: categoryId,
      price: price,
      originalPrice: originalPrice,
      images: List<String>.unmodifiable(images),
      seller: seller.toEntity(),
      discountPercent: discountPercent,
      expiresAt: expiresAt,
      publishedAt: publishedAt,
      views: views,
      isFeatured: isFeatured,
      isAvailable: isAvailable,
      comments: List.unmodifiable(
        comments.map((comment) => comment.toEntity()),
      ),
    );
  }
}
