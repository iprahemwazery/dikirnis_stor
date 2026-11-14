import '../entities/offer.dart';
import '../entities/offers_catalog.dart';

abstract interface class OffersRepository {
  Future<OffersCatalog> getOffersCatalog({bool force = false});

  Future<Offer> getOfferById(String offerId);
}
