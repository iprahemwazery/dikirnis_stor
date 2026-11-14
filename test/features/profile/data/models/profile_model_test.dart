import 'package:dikirnis_stor/features/profile/data/models/profile_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses snake_case JSON and converts to a domain entity', () {
    final model = ProfileModel.fromJson(const {
      'name': 'أحمد محمود',
      'location': 'دكرنس، الدقهلية',
      'member_since': '2024',
      'orders_count': 12,
      'favorites_count': 8,
      'reviews_count': 5,
    });

    expect(model.name, 'أحمد محمود');
    expect(model.location, 'دكرنس، الدقهلية');
    expect(model.memberSince, '2024');

    final entity = model.toEntity();
    expect(entity.name, 'أحمد محمود');
    expect(entity.ordersCount, 12);
    expect(entity.favoritesCount, 8);
    expect(entity.reviewsCount, 5);
  });
}
