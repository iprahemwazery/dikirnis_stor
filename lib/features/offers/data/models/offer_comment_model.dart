import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/offer_comment.dart';

part 'offer_comment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OfferCommentModel {
  const OfferCommentModel({
    required this.id,
    required this.authorName,
    required this.body,
    required this.createdAt,
    this.rating,
  });

  factory OfferCommentModel.fromJson(Map<String, dynamic> json) {
    return _$OfferCommentModelFromJson(json);
  }

  final String id;
  final String authorName;
  final String body;
  final DateTime createdAt;
  final int? rating;

  Map<String, dynamic> toJson() => _$OfferCommentModelToJson(this);

  OfferComment toEntity() {
    return OfferComment(
      id: id,
      authorName: authorName,
      body: body,
      createdAt: createdAt,
      rating: rating,
    );
  }
}
