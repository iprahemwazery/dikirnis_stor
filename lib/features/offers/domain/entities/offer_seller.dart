import 'package:equatable/equatable.dart';

class OfferSeller extends Equatable {
  const OfferSeller({
    required this.id,
    required this.name,
    this.isVerified = false,
    this.location,
    this.memberSince,
    this.phone,
  });

  final String id;
  final String name;
  final bool isVerified;
  final String? location;
  final String? memberSince;
  final String? phone;

  bool get hasPhone => phone != null && phone!.trim().isNotEmpty;

  @override
  List<Object?> get props => [
    id,
    name,
    isVerified,
    location,
    memberSince,
    phone,
  ];
}
