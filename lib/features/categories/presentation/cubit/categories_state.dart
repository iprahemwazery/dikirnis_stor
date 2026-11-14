import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/service_category.dart';

enum CategoriesStatus { initial, loading, success, empty, failure }

const Object _unset = Object();

class CategoriesState extends Equatable {
  const CategoriesState({
    this.status = CategoriesStatus.initial,
    this.allCategories = const [],
    this.categories = const [],
    this.query = '',
    this.failure,
  });

  final CategoriesStatus status;
  final List<ServiceCategory> allCategories;
  final List<ServiceCategory> categories;
  final String query;
  final AppFailure? failure;

  bool get isSearching => query.isNotEmpty;

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<ServiceCategory>? allCategories,
    List<ServiceCategory>? categories,
    String? query,
    Object? failure = _unset,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      allCategories: allCategories ?? this.allCategories,
      categories: categories ?? this.categories,
      query: query ?? this.query,
      failure: identical(failure, _unset)
          ? this.failure
          : failure as AppFailure?,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allCategories,
    categories,
    query,
    failure,
  ];
}
