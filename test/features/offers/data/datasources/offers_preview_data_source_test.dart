import 'dart:convert';
import 'dart:io';

import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/features/offers/data/datasources/offers_preview_data_source.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAssetBundle extends CachingAssetBundle {
  _FakeAssetBundle(this.content);

  final String content;

  @override
  Future<ByteData> load(String key) async {
    if (key != OffersPreviewDataSource.assetPath) {
      throw StateError('Unexpected asset: $key');
    }
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(content)));
  }
}

void main() {
  test('parses the bundled offers preview data', () async {
    final raw = File(OffersPreviewDataSource.assetPath).readAsStringSync();
    final dataSource = OffersPreviewDataSource(
      bundle: _FakeAssetBundle(raw),
      delay: Duration.zero,
    );

    final content = await dataSource.fetchOffersCatalog();

    expect(content.categories, hasLength(8));
    expect(content.offers, hasLength(12));
    expect(content.offers.first.businessName, 'مركز تكنو للتدريب');
    expect(content.offers.first.discountPercent, 40);
    expect(content.offers.first.expiresAt, DateTime(2026, 12, 31));
    expect(content.offers.first.views, 286);
    expect(content.offers.first.isFeatured, isTrue);
    expect(content.offers.first.price, 900);
    expect(content.offers.first.originalPrice, 1500);
    expect(content.offers.first.images, hasLength(3));
    expect(content.offers.first.seller.isVerified, isTrue);
    expect(content.offers.first.comments, hasLength(2));
  });

  test('throws ParsingException for malformed JSON', () async {
    final dataSource = OffersPreviewDataSource(
      bundle: _FakeAssetBundle('{not valid json'),
      delay: Duration.zero,
    );

    await expectLater(
      dataSource.fetchOffersCatalog(),
      throwsA(isA<ParsingException>()),
    );
  });

  test('throws ParsingException when JSON is not an object', () async {
    final dataSource = OffersPreviewDataSource(
      bundle: _FakeAssetBundle('[]'),
      delay: Duration.zero,
    );

    await expectLater(
      dataSource.fetchOffersCatalog(),
      throwsA(isA<ParsingException>()),
    );
  });
}
