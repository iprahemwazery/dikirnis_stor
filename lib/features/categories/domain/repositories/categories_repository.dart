import '../entities/service_category.dart';

abstract interface class CategoriesRepository {
  Future<List<ServiceCategory>> getCategories();
}
