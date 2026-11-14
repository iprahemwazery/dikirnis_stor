// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id'] as String,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String,
      iconKey: json['icon_key'] as String,
      providersCount: (json['providers_count'] as num?)?.toInt() ?? 0,
      subcategoriesCount: (json['subcategories_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_ar': instance.nameAr,
      'name_en': instance.nameEn,
      'icon_key': instance.iconKey,
      'providers_count': instance.providersCount,
      'subcategories_count': instance.subcategoriesCount,
    };
