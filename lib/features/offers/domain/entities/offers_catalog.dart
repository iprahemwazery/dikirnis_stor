import 'package:equatable/equatable.dart';

import '../../../categories/domain/entities/service_category.dart';
import 'offer.dart';

class OffersCatalog extends Equatable {
  const OffersCatalog({required this.categories, required this.offers});

  final List<ServiceCategory> categories;
  final List<Offer> offers;

  @override
  List<Object?> get props => [categories, offers];
}
