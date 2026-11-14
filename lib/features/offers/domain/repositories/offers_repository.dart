import '../entities/offer.dart';
import '../entities/offers_catalog.dart';

abstract interface class OffersRepository {
  Future<OffersCatalog> getOffersCatalog();

  Future<Offer> getOfferById(String offerId);
}
