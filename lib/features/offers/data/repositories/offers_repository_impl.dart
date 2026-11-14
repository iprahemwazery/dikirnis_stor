import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/offer.dart';
import '../../domain/entities/offers_catalog.dart';
import '../../domain/repositories/offers_repository.dart';
import '../datasources/offers_data_source.dart';

class OffersRepositoryImpl implements OffersRepository {
  const OffersRepositoryImpl(this._dataSource);

  final OffersDataSource _dataSource;

  @override
  Future<OffersCatalog> getOffersCatalog() async {
    try {
      final model = await _dataSource.fetchOffersCatalog();
      return model.toEntity();
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UnknownException(cause: error), stackTrace);
    }
  }

  @override
  Future<Offer> getOfferById(String offerId) async {
    final catalog = await getOffersCatalog();
    for (final offer in catalog.offers) {
      if (offer.id == offerId) {
        return offer;
      }
    }
    throw const NotFoundException(
      message: 'The requested offer was not found.',
    );
  }
}
