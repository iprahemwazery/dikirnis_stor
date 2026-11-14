import 'package:dikirnis_stor/features/categories/data/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses snake_case JSON and converts to a domain entity', () {
    final model = CategoryModel.fromJson(const {
      'id': 'grocery',
      'name_ar': 'بقالة وسوبرماركت',
      'name_en': 'Grocery & supermarkets',
      'icon_key': 'grocery',
      'providers_count': 18,
    });

    expect(model.nameAr, 'بقالة وسوبرماركت');
    expect(model.nameEn, 'Grocery & supermarkets');
    expect(model.iconKey, 'grocery');

    final entity = model.toEntity();
    expect(entity.id, 'grocery');
    expect(entity.providersCount, 18);
    expect(entity.localizedName('ar'), 'بقالة وسوبرماركت');
    expect(entity.localizedName('en'), 'Grocery & supermarkets');
  });

  test('defaults providersCount to zero when it is missing', () {
    final model = CategoryModel.fromJson(const {
      'id': 'beauty',
      'name_ar': 'صحة وجمال',
      'name_en': 'Health & beauty',
      'icon_key': 'beauty',
    });

    expect(model.providersCount, 0);
  });
}
