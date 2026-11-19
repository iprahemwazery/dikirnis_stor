import 'dart:convert';
import 'dart:io';

import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/features/jobs/data/datasources/jobs_preview_data_source.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAssetBundle extends CachingAssetBundle {
  _FakeAssetBundle(this.content);

  final String content;

  @override
  Future<ByteData> load(String key) async {
    if (key != JobsPreviewDataSource.assetPath) {
      throw StateError('Unexpected asset: $key');
    }
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(content)));
  }
}

void main() {
  test('parses the bundled jobs preview data', () async {
    final raw = File('assets/data/jobs_preview.json').readAsStringSync();
    final dataSource = JobsPreviewDataSource(
      bundle: _FakeAssetBundle(raw),
      delay: Duration.zero,
    );

    final model = await dataSource.fetchJobsCatalog();

    expect(model.categories, hasLength(6));
    expect(model.categories.first.id, 'technology');
    expect(model.vacancies, hasLength(6));
    expect(model.vacancies.first.id, 'vacancy_flutter_developer');
    expect(model.vacancies.first.companyName, 'مركز تكنو للتدريب');
    expect(model.candidates, hasLength(6));
    expect(model.candidates.first.fullName, 'أحمد محمود');
  });

  test('maps parsed models to domain entities', () async {
    final raw = File('assets/data/jobs_preview.json').readAsStringSync();
    final dataSource = JobsPreviewDataSource(
      bundle: _FakeAssetBundle(raw),
      delay: Duration.zero,
    );

    final catalog = (await dataSource.fetchJobsCatalog()).toEntity();
    final vacancy = catalog.vacancies.first;
    final candidate = catalog.candidates.first;

    expect(vacancy.title, 'مطور Flutter أول');
    expect(vacancy.hasSalary, isTrue);
    expect(vacancy.hasContact, isTrue);
    expect(catalog.categories.first.nameAr, 'تقنية المعلومات');
    expect(candidate.professionalTitle, 'مطور Flutter');
    expect(candidate.skills, isNotEmpty);
    expect(candidate.initials, 'أم');
  });

  test('throws ParsingException for malformed JSON', () async {
    final dataSource = JobsPreviewDataSource(
      bundle: _FakeAssetBundle('{not json'),
      delay: Duration.zero,
    );

    await expectLater(
      dataSource.fetchJobsCatalog(),
      throwsA(isA<ParsingException>()),
    );
  });

  test('throws ParsingException when JSON is not an object', () async {
    final dataSource = JobsPreviewDataSource(
      bundle: _FakeAssetBundle('[]'),
      delay: Duration.zero,
    );

    await expectLater(
      dataSource.fetchJobsCatalog(),
      throwsA(isA<ParsingException>()),
    );
  });
}
