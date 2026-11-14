import 'dart:convert';
import 'dart:io';

import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/features/profile/data/datasources/profile_preview_data_source.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAssetBundle extends CachingAssetBundle {
  _FakeAssetBundle(this.content);

  final String content;

  @override
  Future<ByteData> load(String key) async {
    if (key != ProfilePreviewDataSource.assetPath) {
      throw StateError('Unexpected asset: $key');
    }
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(content)));
  }
}

void main() {
  test('parses the bundled profile preview data', () async {
    final raw = File('assets/data/profile_preview.json').readAsStringSync();
    final dataSource = ProfilePreviewDataSource(
      bundle: _FakeAssetBundle(raw),
      delay: Duration.zero,
    );

    final profile = await dataSource.fetchProfile();

    expect(profile.name, 'أحمد محمود');
    expect(profile.location, 'دكرنس، الدقهلية');
    expect(profile.memberSince, '2024');
    expect(profile.ordersCount, 12);
    expect(profile.favoritesCount, 8);
    expect(profile.reviewsCount, 5);
  });

  test('throws ParsingException for malformed JSON', () async {
    final dataSource = ProfilePreviewDataSource(
      bundle: _FakeAssetBundle('{not valid json'),
      delay: Duration.zero,
    );

    await expectLater(
      dataSource.fetchProfile(),
      throwsA(isA<ParsingException>()),
    );
  });

  test('throws ParsingException when JSON is not an object', () async {
    final dataSource = ProfilePreviewDataSource(
      bundle: _FakeAssetBundle('[]'),
      delay: Duration.zero,
    );

    await expectLater(
      dataSource.fetchProfile(),
      throwsA(isA<ParsingException>()),
    );
  });
}
