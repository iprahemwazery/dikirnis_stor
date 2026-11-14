import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/home_category.dart';

part 'home_category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HomeCategoryModel {
  const HomeCategoryModel({
    required this.id,
    required this.name,
    required this.iconKey,
    @JsonKey(name: 'is_more', defaultValue: false) this.isMore = false,
  });

  factory HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$HomeCategoryModelFromJson(json);
  }

  final String id;
  final String name;
  final String iconKey;
  final bool isMore;

  Map<String, dynamic> toJson() => _$HomeCategoryModelToJson(this);

  HomeCategory toEntity() {
    return HomeCategory(id: id, name: name, iconKey: iconKey, isMore: isMore);
  }
}
