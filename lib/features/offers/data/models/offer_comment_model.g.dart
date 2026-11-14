// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferCommentModel _$OfferCommentModelFromJson(Map<String, dynamic> json) =>
    OfferCommentModel(
      id: json['id'] as String,
      authorName: json['author_name'] as String,
      body: json['body'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      rating: (json['rating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OfferCommentModelToJson(OfferCommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_name': instance.authorName,
      'body': instance.body,
      'created_at': instance.createdAt.toIso8601String(),
      'rating': instance.rating,
    };
