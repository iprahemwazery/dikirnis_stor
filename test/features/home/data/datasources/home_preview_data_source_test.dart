import 'dart:convert';
import 'dart:io';

import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/features/home/data/datasources/home_preview_data_source.dart';
import 'package:dikirnis_stor/features/home/data/models/business_model.dart';
import 'package:dikirnis_stor/features/home/data/models/home_category_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAssetBundle extends CachingAssetBundle {
  _FakeAssetBundle(this.content);

  final String content;

  @override
  Future<ByteData> load(String key) async {
    if (key != HomePreviewDataSource.assetPath) {
      throw StateError('Unexpected asset: $key');
    }
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(content)));
  }
}

void main() {
  test('parses the bundled home preview data', () async {
    final raw = File('assets/data/home_preview.json').readAsStringSync();
    final dataSource = HomePreviewDataSource(
      bundle: _FakeAssetBundle(raw),
      delay: Duration.zero,
    );

    final content = await dataSource.fetchHomeContent();

    expect(content.userName, 'أحمد محمود');
    expect(content.userLocation, 'دكرنس، الدقهلية');
    expect(content.banners, hasLength(3));
    expect(content.categories, hasLength(12));
    expect(content.categories.first.name, 'المبيعات التجارية');
    expect(content.categories[8].name, 'عرض المزيد');
    expect(content.categories[8].isMore, isTrue);
    expect(content.categories.last.name, 'النقل والتوصيل');
    expect(content.mostViewed, hasLength(4));
    expect(content.mostViewed.first.rank, 1);
    expect(content.mostViewed.first.views, 1840);
    expect(content.recentlyAdded.first.isNew, isTrue);
    expect(content.medical.first.isVerified, isTrue);
    expect(content.medical[2].isSponsored, isTrue);
    expect(content.advertisement?.advertiserName, 'Crocodile');
    expect(content.restaurants, hasLength(4));
  });

  test('maps parsed models to domain entities', () async {
    final raw = File('assets/data/home_preview.json').readAsStringSync();
    final dataSource = HomePreviewDataSource(
      bundle: _FakeAssetBundle(raw),
      delay: Duration.zero,
    );

    final content = (await dataSource.fetchHomeContent()).toEntity();

    expect(content.categories[8].isMore, isTrue);
    expect(content.mostViewed.first.name, 'أسماك النيل');
    expect(content.medical[2].isSponsored, isTrue);
    expect(content.advertisement?.id, 'crocodile');
  });

  test('applies model defaults for optional business fields', () {
    final business = BusinessModel.fromJson({
      'id': 'business_1',
      'name': 'متجر',
      'location': 'دكرنس',
      'image': 'assets/images/businesses/grocery.jpg',
      'rating': 4.5,
    });

    expect(business.views, 0);
    expect(business.rank, isNull);
    expect(business.isNew, isFalse);
    expect(business.isVerified, isFalse);
    expect(business.isSponsored, isFalse);
  });

  test('applies category defaults for missing is_more', () {
    final category = HomeCategoryModel.fromJson({
      'id': 'services',
      'name': 'الخدمات',
      'icon_key': 'services',
    });

    expect(category.isMore, isFalse);
  });

  test('throws ParsingException for malformed JSON', () async {
    final dataSource = HomePreviewDataSource(
      bundle: _FakeAssetBundle('{not valid json'),
      delay: Duration.zero,
    );

    await expectLater(
      dataSource.fetchHomeContent(),
      throwsA(isA<ParsingException>()),
    );
  });

  test('throws ParsingException when JSON is not an object', () async {
    final dataSource = HomePreviewDataSource(
      bundle: _FakeAssetBundle('[]'),
      delay: Duration.zero,
    );

    await expectLater(
      dataSource.fetchHomeContent(),
      throwsA(isA<ParsingException>()),
    );
  });
}
