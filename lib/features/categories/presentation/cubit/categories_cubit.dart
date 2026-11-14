import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/service_category.dart';
import '../../domain/repositories/categories_repository.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._repository) : super(const CategoriesState());

  final CategoriesRepository _repository;

  Future<void> load({bool force = false}) async {
    if (state.status == CategoriesStatus.loading) {
      return;
    }
    if (!force &&
        (state.status == CategoriesStatus.success ||
            state.status == CategoriesStatus.empty)) {
      return;
    }

    emit(state.copyWith(status: CategoriesStatus.loading, failure: null));

    try {
      final categories = await _repository.getCategories();
      if (isClosed) {
        return;
      }

      final allCategories = List<ServiceCategory>.unmodifiable(categories);
      final filtered = List<ServiceCategory>.unmodifiable(
        _filter(allCategories, state.query),
      );

      emit(
        state.copyWith(
          status: allCategories.isEmpty
              ? CategoriesStatus.empty
              : CategoriesStatus.success,
          allCategories: allCategories,
          categories: filtered,
          failure: null,
        ),
      );
    } catch (error) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          status: CategoriesStatus.failure,
          failure: AppFailure.fromException(error),
        ),
      );
    }
  }

  Future<void> refresh() => load(force: true);

  void search(String rawQuery) {
    final query = rawQuery.trim();
    if (query == state.query) {
      return;
    }

    if (state.status != CategoriesStatus.success &&
        state.status != CategoriesStatus.empty) {
      emit(state.copyWith(query: query));
      return;
    }

    final filtered = List<ServiceCategory>.unmodifiable(
      _filter(state.allCategories, query),
    );
    emit(state.copyWith(query: query, categories: filtered));
  }

  List<ServiceCategory> _filter(
    Iterable<ServiceCategory> categories,
    String query,
  ) {
    if (query.isEmpty) {
      return categories.toList(growable: false);
    }

    final normalizedQuery = query.toLowerCase();
    return categories
        .where(
          (category) =>
              category.nameAr.contains(query) ||
              category.nameEn.toLowerCase().contains(normalizedQuery),
        )
        .toList(growable: false);
  }
}
