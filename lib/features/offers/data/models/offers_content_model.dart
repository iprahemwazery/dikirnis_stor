import 'package:json_annotation/json_annotation.dart';

import '../../../categories/data/models/category_model.dart';
import '../../domain/entities/offers_catalog.dart';
import 'offer_model.dart';

part 'offers_content_model.g.dart';

@JsonSerializable()
class OffersContentModel {
  const OffersContentModel({required this.categories, required this.offers});

  factory OffersContentModel.fromJson(Map<String, dynamic> json) {
    return _$OffersContentModelFromJson(json);
  }

  final List<CategoryModel> categories;
  final List<OfferModel> offers;

  Map<String, dynamic> toJson() => _$OffersContentModelToJson(this);

  OffersCatalog toEntity() {
    return OffersCatalog(
      categories: categories
          .map((category) => category.toEntity())
          .toList(growable: false),
      offers: offers.map((offer) => offer.toEntity()).toList(growable: false),
    );
  }
}
