import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/offer.dart';
import '../../domain/entities/offers_catalog.dart';
import '../../domain/repositories/offers_repository.dart';
import '../datasources/offers_data_source.dart';

class OffersRepositoryImpl implements OffersRepository {
  OffersRepositoryImpl(
    this._dataSource, {
    this.cacheTtl = const Duration(minutes: 2),
  });

  final OffersDataSource _dataSource;
  final Duration cacheTtl;

  OffersCatalog? _cachedCatalog;
  DateTime? _cachedAt;
  Future<OffersCatalog>? _pendingRequest;

  @override
  Future<OffersCatalog> getOffersCatalog({bool force = false}) {
    if (!force && _hasFreshCache) {
      return Future.value(_cachedCatalog);
    }

    final pendingRequest = _pendingRequest;
    if (!force && pendingRequest != null) {
      return pendingRequest;
    }

    final request = _loadCatalog();
    late final Future<OffersCatalog> trackedRequest;
    trackedRequest = request.whenComplete(() {
      if (identical(_pendingRequest, trackedRequest)) {
        _pendingRequest = null;
      }
    });
    _pendingRequest = trackedRequest;
    return trackedRequest;
  }

  bool get _hasFreshCache {
    final cachedAt = _cachedAt;
    if (_cachedCatalog == null || cachedAt == null) {
      return false;
    }
    return DateTime.now().difference(cachedAt) < cacheTtl;
  }

  Future<OffersCatalog> _loadCatalog() async {
    try {
      final model = await _dataSource.fetchOffersCatalog();
      final catalog = model.toEntity();
      _cachedCatalog = catalog;
      _cachedAt = DateTime.now();
      return catalog;
    } on AppException catch (error) {
      if (_cachedCatalog != null &&
          (error is NetworkException ||
              error is RequestTimeoutException ||
              error is ServerException)) {
        return _cachedCatalog!;
      }
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
