import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/service_category.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_data_source.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  const CategoriesRepositoryImpl(this._dataSource);

  final CategoriesDataSource _dataSource;

  @override
  Future<List<ServiceCategory>> getCategories() async {
    try {
      final models = await _dataSource.fetchCategories();
      return models.map((model) => model.toEntity()).toList(growable: false);
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UnknownException(cause: error), stackTrace);
    }
  }
}
