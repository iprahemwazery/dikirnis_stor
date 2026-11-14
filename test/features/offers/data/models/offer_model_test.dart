import 'package:dikirnis_stor/features/offers/data/models/offer_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses snake_case JSON and converts to a domain entity', () {
    final model = OfferModel.fromJson(const {
      'id': 'offer_techno_training',
      'business_name': 'مركز تكنو للتدريب',
      'title': 'خصم 40% على دورات البرمجة',
      'description': 'دورات عملية في تطوير الويب.',
      'image': 'assets/images/businesses/electronics.jpg',
      'category_id': 'education',
      'price': 900,
      'original_price': 1500,
      'images': [
        'assets/images/businesses/electronics.jpg',
        'assets/images/businesses/lab.jpg',
      ],
      'discount_percent': 40,
      'expires_at': '2026-12-31',
      'published_at': '2026-11-01',
      'views': 286,
      'is_featured': true,
      'seller': {
        'id': 'seller_techno_training',
        'name': 'مركز تكنو للتدريب',
        'is_verified': true,
        'location': 'دكرنس، الدقهلية',
        'member_since': '2023',
      },
      'comments': [
        {
          'id': 'comment_1',
          'author_name': 'محمود ع.',
          'body': 'دورة ممتازة',
          'created_at': '2026-11-08',
          'rating': 5,
        },
      ],
    });

    expect(model.businessName, 'مركز تكنو للتدريب');
    expect(model.categoryId, 'education');
    expect(model.discountPercent, 40);
    expect(model.expiresAt, DateTime(2026, 12, 31));
    expect(model.views, 286);
    expect(model.isFeatured, isTrue);
    expect(model.price, 900);
    expect(model.originalPrice, 1500);
    expect(model.seller.isVerified, isTrue);
    expect(model.comments, hasLength(1));

    final entity = model.toEntity();
    expect(entity.id, 'offer_techno_training');
    expect(entity.title, 'خصم 40% على دورات البرمجة');
    expect(entity.hasDiscount, isTrue);
    expect(entity.expiresAt, DateTime(2026, 12, 31));
    expect(entity.galleryImages, hasLength(2));
    expect(entity.seller.location, 'دكرنس، الدقهلية');
    expect(entity.comments.single.rating, 5);
  });

  test('applies defaults when optional fields are missing', () {
    final model = OfferModel.fromJson(const {
      'id': 'offer_basic',
      'business_name': 'متجر',
      'title': 'عرض',
      'description': 'وصف',
      'image': 'assets/images/businesses/store.jpg',
      'category_id': 'commercial',
      'price': 100,
      'seller': {'id': 'seller_basic', 'name': 'متجر'},
    });

    expect(model.discountPercent, isNull);
    expect(model.expiresAt, isNull);
    expect(model.views, 0);
    expect(model.isFeatured, isFalse);
    expect(model.isAvailable, isTrue);
    expect(model.images, isEmpty);
    expect(model.comments, isEmpty);
    expect(model.toEntity().hasDiscount, isFalse);
    expect(model.toEntity().galleryImages, [model.image]);
  });
}
