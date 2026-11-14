// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersContentModel _$OffersContentModelFromJson(Map<String, dynamic> json) =>
    OffersContentModel(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      offers: (json['offers'] as List<dynamic>)
          .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OffersContentModelToJson(OffersContentModel instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'offers': instance.offers,
    };
