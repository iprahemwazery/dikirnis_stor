import '../models/home_content_model.dart';

abstract interface class HomeDataSource {
  Future<HomeContentModel> fetchHomeContent();
}
