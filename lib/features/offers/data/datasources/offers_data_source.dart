import '../models/offers_content_model.dart';

abstract interface class OffersDataSource {
  Future<OffersContentModel> fetchOffersCatalog();
}
