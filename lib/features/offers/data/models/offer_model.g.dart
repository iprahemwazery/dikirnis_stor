// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
  id: json['id'] as String,
  businessName: json['business_name'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  image: json['image'] as String,
  categoryId: json['category_id'] as String,
  price: (json['price'] as num).toDouble(),
  seller: OfferSellerModel.fromJson(json['seller'] as Map<String, dynamic>),
  originalPrice: (json['original_price'] as num?)?.toDouble(),
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  discountPercent: (json['discount_percent'] as num?)?.toInt(),
  expiresAt: json['expires_at'] == null
      ? null
      : DateTime.parse(json['expires_at'] as String),
  publishedAt: json['published_at'] == null
      ? null
      : DateTime.parse(json['published_at'] as String),
  views: (json['views'] as num?)?.toInt() ?? 0,
  isFeatured: json['is_featured'] as bool? ?? false,
  isAvailable: json['is_available'] as bool? ?? true,
  comments:
      (json['comments'] as List<dynamic>?)
          ?.map((e) => OfferCommentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_name': instance.businessName,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'category_id': instance.categoryId,
      'price': instance.price,
      'original_price': instance.originalPrice,
      'images': instance.images,
      'seller': instance.seller,
      'discount_percent': instance.discountPercent,
      'expires_at': instance.expiresAt?.toIso8601String(),
      'published_at': instance.publishedAt?.toIso8601String(),
      'views': instance.views,
      'is_featured': instance.isFeatured,
      'is_available': instance.isAvailable,
      'comments': instance.comments,
    };
