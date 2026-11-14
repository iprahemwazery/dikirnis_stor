import 'package:dikirnis_stor/features/offers/data/models/offers_content_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps categories and offers to a domain catalog', () {
    final model = OffersContentModel.fromJson(const {
      'categories': [
        {
          'id': 'education',
          'name_ar': 'تعليم وتدريب',
          'name_en': 'Education & training',
          'icon_key': 'education',
          'subcategories_count': 10,
        },
      ],
      'offers': [
        {
          'id': 'offer_techno_training',
          'business_name': 'مركز تكنو للتدريب',
          'title': 'خصم 40% على دورات البرمجة',
          'description': 'دورات عملية في تطوير الويب.',
          'image': 'assets/images/businesses/electronics.jpg',
          'category_id': 'education',
          'price': 900,
          'seller': {
            'id': 'seller_techno_training',
            'name': 'مركز تكنو للتدريب',
          },
          'discount_percent': 40,
          'expires_at': '2026-12-31',
          'views': 286,
          'is_featured': true,
        },
      ],
    });

    final catalog = model.toEntity();

    expect(catalog.categories, hasLength(1));
    expect(catalog.categories.single.id, 'education');
    expect(catalog.offers, hasLength(1));
    expect(catalog.offers.single.businessName, 'مركز تكنو للتدريب');
    expect(catalog.offers.single.categoryId, catalog.categories.single.id);
    expect(catalog.offers.single.price, 900);
    expect(catalog.offers.single.seller.id, 'seller_techno_training');
  });
}
