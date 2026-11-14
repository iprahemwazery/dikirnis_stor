import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._dataSource);

  final ProfileDataSource _dataSource;

  @override
  Future<UserProfile> getProfile() async {
    try {
      final model = await _dataSource.fetchProfile();
      return model.toEntity();
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UnknownException(cause: error), stackTrace);
    }
  }
}
