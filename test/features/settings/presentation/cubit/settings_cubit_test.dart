import 'package:dikirnis_stor/features/settings/domain/entities/app_settings.dart';
import 'package:dikirnis_stor/features/settings/domain/repositories/settings_repository.dart';
import 'package:dikirnis_stor/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSettingsRepository implements SettingsRepository {
  _FakeSettingsRepository({this.settings = const AppSettings()});

  AppSettings settings;
  bool failWrites = false;
  int writeCount = 0;

  @override
  AppSettings read() => settings;

  @override
  Future<void> write(AppSettings settings) async {
    if (failWrites) {
      throw StateError('write failed');
    }
    writeCount++;
    this.settings = settings;
  }
}

void main() {
  test('persists language and theme changes', () async {
    final repository = _FakeSettingsRepository();
    final cubit = SettingsCubit(repository);

    await cubit.setLanguage(AppLanguage.arabic);
    await cubit.setTheme(AppThemePreference.dark);

    expect(cubit.state.language, AppLanguage.arabic);
    expect(cubit.state.theme, AppThemePreference.dark);
    expect(repository.writeCount, 2);
    expect(repository.settings.language, AppLanguage.arabic);
    expect(repository.settings.theme, AppThemePreference.dark);

    await cubit.close();
  });

  test('rolls back when persistence fails', () async {
    final repository = _FakeSettingsRepository(
      settings: const AppSettings(language: AppLanguage.english),
    )..failWrites = true;
    final cubit = SettingsCubit(repository);

    await expectLater(
      cubit.setLanguage(AppLanguage.arabic),
      throwsA(isA<StateError>()),
    );

    expect(cubit.state.language, AppLanguage.english);
    await cubit.close();
  });

  test('ignores repeated selections', () async {
    final repository = _FakeSettingsRepository();
    final cubit = SettingsCubit(repository);

    await cubit.setLanguage(AppLanguage.system);
    await cubit.setTheme(AppThemePreference.system);

    expect(repository.writeCount, 0);
    await cubit.close();
  });
}
