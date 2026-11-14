import 'package:equatable/equatable.dart';

class OfferComment extends Equatable {
  const OfferComment({
    required this.id,
    required this.authorName,
    required this.body,
    required this.createdAt,
    this.rating,
  });

  final String id;
  final String authorName;
  final String body;
  final DateTime createdAt;
  final int? rating;

  @override
  List<Object?> get props => [id, authorName, body, createdAt, rating];
}
