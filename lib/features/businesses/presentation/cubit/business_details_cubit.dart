import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/business.dart';
import '../../../home/domain/entities/home_content.dart';
import '../../../home/domain/repositories/home_repository.dart';
import 'business_details_state.dart';

class BusinessDetailsCubit extends Cubit<BusinessDetailsState> {
  BusinessDetailsCubit(this._repository) : super(const BusinessDetailsState());

  final HomeRepository _repository;
  String? _lastBusinessId;
  int _requestGeneration = 0;

  Future<void> load(String businessId) {
    _lastBusinessId = businessId;
    return _load(businessId);
  }

  Future<void> refresh() async {
    final businessId = _lastBusinessId;
    if (businessId == null) {
      return;
    }
    await _load(businessId);
  }

  Future<void> _load(String businessId) async {
    final generation = ++_requestGeneration;
    emit(
      BusinessDetailsState(
        status: BusinessDetailsStatus.loading,
        business: state.business,
      ),
    );

    try {
      final content = await _repository.getHomeContent();
      if (isClosed || generation != _requestGeneration) {
        return;
      }

      final business = _findBusiness(content, businessId);
      if (business == null) {
        emit(
          const BusinessDetailsState(status: BusinessDetailsStatus.notFound),
        );
        return;
      }

      emit(
        BusinessDetailsState(
          status: BusinessDetailsStatus.success,
          business: business,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (error) {
      if (isClosed || generation != _requestGeneration) {
        return;
      }
      emit(
        BusinessDetailsState(
          status: BusinessDetailsStatus.failure,
          failure: AppFailure.fromException(error),
        ),
      );
    }
  }

  Business? _findBusiness(HomeContent content, String businessId) {
    for (final businesses in [
      content.mostViewed,
      content.recentlyAdded,
      content.medical,
      content.restaurants,
      ...content.businesses.values,
    ]) {
      for (final business in businesses) {
        if (business.id == businessId) {
          return business;
        }
      }
    }
    return null;
  }
}
