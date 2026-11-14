import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/service_category.dart';

part 'category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.iconKey,
    @JsonKey(defaultValue: 0) this.providersCount = 0,
    @JsonKey(defaultValue: 0) this.subcategoriesCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryModelFromJson(json);
  }

  final String id;
  final String nameAr;
  final String nameEn;
  final String iconKey;
  final int providersCount;
  final int subcategoriesCount;

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  ServiceCategory toEntity() {
    return ServiceCategory(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      iconKey: iconKey,
      providersCount: providersCount,
      subcategoriesCount: subcategoriesCount,
    );
  }
}
