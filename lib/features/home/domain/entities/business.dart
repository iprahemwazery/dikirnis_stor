import 'package:equatable/equatable.dart';

class Business extends Equatable {
  const Business({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.rating,
    this.views = 0,
    this.description,
    this.rank,
    this.isNew = false,
    this.isVerified = false,
    this.isSponsored = false,
  });

  final String id;
  final String name;
  final String location;
  final String image;
  final double rating;
  final int views;
  final String? description;
  final int? rank;
  final bool isNew;
  final bool isVerified;
  final bool isSponsored;

  @override
  List<Object?> get props => [
    id,
    name,
    location,
    image,
    rating,
    views,
    description,
    rank,
    isNew,
    isVerified,
    isSponsored,
  ];
}
