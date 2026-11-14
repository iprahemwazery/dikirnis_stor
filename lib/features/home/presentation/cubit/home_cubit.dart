import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState());

  final HomeRepository _repository;

  Future<void> load({bool force = false}) async {
    if (state.status == HomeStatus.loading) {
      return;
    }
    if (!force &&
        (state.status == HomeStatus.success ||
            state.status == HomeStatus.empty)) {
      return;
    }

    emit(state.copyWith(status: HomeStatus.loading, failure: null));

    try {
      final content = await _repository.getHomeContent();
      if (isClosed) {
        return;
      }

      emit(
        state.copyWith(
          status: content.isEmpty ? HomeStatus.empty : HomeStatus.success,
          content: content,
          failure: null,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (error) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          failure: AppFailure.fromException(error),
        ),
      );
    }
  }

  Future<void> refresh() => load(force: true);

  void submitSearch(String query) {
    final normalizedQuery = query.trim();
    if (normalizedQuery == state.searchQuery) {
      return;
    }
    emit(state.copyWith(searchQuery: normalizedQuery));
  }

  void dismissAdvertisement() {
    if (state.advertisementDismissed) {
      return;
    }
    emit(state.copyWith(advertisementDismissed: true));
  }
}
