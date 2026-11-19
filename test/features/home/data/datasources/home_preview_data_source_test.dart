import 'dart:convert';
import 'dart:io';

import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/features/home/data/datasources/home_preview_data_source.dart';
import 'package:dikirnis_stor/features/home/data/models/business_model.dart';
import 'package:dikirnis_stor/features/home/data/models/home_category_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAssetBundle extends CachingAssetBundle {
  _FakeAssetBundle(this.content, {this.catalogContent});

  final String content;
  final String? catalogContent;

  @override
  Future<ByteData> load(String key) async {
    final source = switch (key) {
      HomePreviewDataSource.assetPath => content,
      HomePreviewDataSource.catalogAssetPath => catalogContent,
      _ => null,
    };
    if (source == null) {
      throw StateError('Unexpected asset: $key');
    }
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(source)));
  }
}

void main() {
  test('parses the bundled home preview data', () async {
    final raw = File('assets/data/home_preview.json').readAsStringSync();
    final catalog = File(
      'assets/data/businesses_preview.json',
    ).readAsStringSync();
    final dataSource = HomePreviewDataSource(
      bundle: _FakeAssetBundle(raw, catalogContent: catalog),
      delay: Duration.zero,
    );

    final content = await dataSource.fetchHomeContent();

    expect(content.userName.trim(), 'عبدالله عيطه');
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
    expect(content.businesses, hasLength(10));
    expect(content.businesses['commercial_sales'], hasLength(4));
    expect(content.businesses['commercial_sales']!.first.name, 'تكنو ستور');
    expect(content.businesses['transport'], hasLength(3));
    for (final category in content.categories) {
      if (category.isMore || category.id == 'jobs') {
        continue;
      }
      expect(
        content.businesses[category.id],
        isNotEmpty,
        reason: 'Missing preview businesses for ${category.id}',
      );
    }
  });

  test('maps parsed models to domain entities', () async {
    final raw = File('assets/data/home_preview.json').readAsStringSync();
    final catalog = File(
      'assets/data/businesses_preview.json',
    ).readAsStringSync();
    final dataSource = HomePreviewDataSource(
      bundle: _FakeAssetBundle(raw, catalogContent: catalog),
      delay: Duration.zero,
    );

    final content = (await dataSource.fetchHomeContent()).toEntity();

    expect(content.categories[8].isMore, isTrue);
    expect(content.mostViewed.first.name, 'أسماك النيل');
    expect(content.medical[2].isSponsored, isTrue);
    expect(content.advertisement?.id, 'crocodile');
    expect(content.businessesOf('education'), hasLength(3));
    expect(content.businessesOf('education').first.name, 'سنتر النخبة');
    expect(content.businessesOf('missing'), isEmpty);
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
