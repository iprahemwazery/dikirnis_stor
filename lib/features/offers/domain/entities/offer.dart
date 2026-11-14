import 'package:equatable/equatable.dart';

import 'offer_comment.dart';
import 'offer_seller.dart';

class Offer extends Equatable {
  const Offer({
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
    this.views = 0,
    this.isFeatured = false,
    this.isAvailable = true,
    this.comments = const [],
  });

  final String id;
  final String businessName;
  final String title;
  final String description;
  final String image;
  final String categoryId;
  final double price;
  final double? originalPrice;
  final List<String> images;
  final OfferSeller seller;
  final int? discountPercent;
  final DateTime? expiresAt;
  final DateTime? publishedAt;
  final int views;
  final bool isFeatured;
  final bool isAvailable;
  final List<OfferComment> comments;

  bool get hasDiscount => discountPercent != null && discountPercent! > 0;

  bool get hasOriginalPrice => originalPrice != null && originalPrice! > price;

  List<String> get galleryImages {
    final paths = images.where((path) => path.trim().isNotEmpty).toList();
    if (paths.isEmpty) {
      return [image];
    }
    return paths;
  }

  @override
  List<Object?> get props => [
    id,
    businessName,
    title,
    description,
    image,
    categoryId,
    price,
    originalPrice,
    images,
    seller,
    discountPercent,
    expiresAt,
    publishedAt,
    views,
    isFeatured,
    isAvailable,
    comments,
  ];
}
