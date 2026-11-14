import '../models/category_model.dart';

abstract interface class CategoriesDataSource {
  Future<List<CategoryModel>> fetchCategories();
}
