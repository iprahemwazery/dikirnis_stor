import 'package:dikirnis_stor/features/settings/data/repositories/shared_preferences_settings_repository.dart';
import 'package:dikirnis_stor/features/settings/domain/entities/app_settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('returns defaults when no settings are stored', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = SharedPreferencesSettingsRepository(preferences);

    expect(
      repository.read(),
      const AppSettings(
        language: AppLanguage.system,
        theme: AppThemePreference.system,
      ),
    );
  });

  test('persists and restores the selected language and theme', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = SharedPreferencesSettingsRepository(preferences);

    await repository.write(
      const AppSettings(
        language: AppLanguage.english,
        theme: AppThemePreference.dark,
      ),
    );

    final restored = SharedPreferencesSettingsRepository(preferences).read();
    expect(restored.language, AppLanguage.english);
    expect(restored.theme, AppThemePreference.dark);
  });

  test('falls back to safe defaults for unknown stored values', () async {
    SharedPreferences.setMockInitialValues({
      'settings.language': 'unknown-language',
      'settings.theme': 'unknown-theme',
    });
    final preferences = await SharedPreferences.getInstance();
    final repository = SharedPreferencesSettingsRepository(preferences);

    final settings = repository.read();
    expect(settings.language, AppLanguage.system);
    expect(settings.theme, AppThemePreference.system);
  });
}
