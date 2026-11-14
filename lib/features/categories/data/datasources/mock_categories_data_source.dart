import '../models/category_model.dart';
import 'categories_data_source.dart';

class MockCategoriesDataSource implements CategoriesDataSource {
  const MockCategoriesDataSource();

  static const List<Map<String, dynamic>> _mockCategories = [
    {
      'id': 'medical',
      'name_ar': 'القطاع الطبي',
      'name_en': 'Medical sector',
      'icon_key': 'medical',
      'subcategories_count': 2,
    },
    {
      'id': 'restaurants',
      'name_ar': 'المطاعم والكافيهات',
      'name_en': 'Restaurants & cafes',
      'icon_key': 'restaurant',
      'subcategories_count': 16,
    },
    {
      'id': 'commercial',
      'name_ar': 'المحلات التجارية',
      'name_en': 'Commercial stores',
      'icon_key': 'commercial',
      'subcategories_count': 25,
    },
    {
      'id': 'education',
      'name_ar': 'تعليم وتدريب',
      'name_en': 'Education & training',
      'icon_key': 'education',
      'subcategories_count': 10,
    },
    {
      'id': 'services',
      'name_ar': 'الخدمات',
      'name_en': 'Services',
      'icon_key': 'services',
      'subcategories_count': 4,
    },
    {
      'id': 'home_goods',
      'name_ar': 'خيرات البيت',
      'name_en': 'Home goods',
      'icon_key': 'home_goods',
      'subcategories_count': 6,
    },
    {
      'id': 'sports',
      'name_ar': 'رياضة وترفيه',
      'name_en': 'Sports & entertainment',
      'icon_key': 'sports',
      'subcategories_count': 6,
    },
    {
      'id': 'transport',
      'name_ar': 'النقل والتوصيل',
      'name_en': 'Transport & delivery',
      'icon_key': 'transport',
      'subcategories_count': 5,
    },
    {
      'id': 'religion_society',
      'name_ar': 'الدين والمجتمع',
      'name_en': 'Religion & community',
      'icon_key': 'religion',
      'subcategories_count': 6,
    },
    {
      'id': 'government',
      'name_ar': 'مصالح حكومية',
      'name_en': 'Government services',
      'icon_key': 'government',
      'subcategories_count': 6,
    },
  ];

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return _mockCategories.map(CategoryModel.fromJson).toList(growable: false);
  }
}
