import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/home_content.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._dataSource);

  final HomeDataSource _dataSource;

  @override
  Future<HomeContent> getHomeContent() async {
    try {
      final model = await _dataSource.fetchHomeContent();
      return model.toEntity();
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UnknownException(cause: error), stackTrace);
    }
  }
}
