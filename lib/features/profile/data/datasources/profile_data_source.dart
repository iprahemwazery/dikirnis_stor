import '../models/profile_model.dart';

abstract interface class ProfileDataSource {
  Future<ProfileModel> fetchProfile();
}
