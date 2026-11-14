// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCategoryModel _$HomeCategoryModelFromJson(Map<String, dynamic> json) =>
    HomeCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      iconKey: json['icon_key'] as String,
      isMore: json['is_more'] as bool? ?? false,
    );

Map<String, dynamic> _$HomeCategoryModelToJson(HomeCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon_key': instance.iconKey,
      'is_more': instance.isMore,
    };
