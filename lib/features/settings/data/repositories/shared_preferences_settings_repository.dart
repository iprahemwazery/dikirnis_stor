import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

class SharedPreferencesSettingsRepository implements SettingsRepository {
  const SharedPreferencesSettingsRepository(this._preferences);

  static const String _languageKey = 'settings.language';
  static const String _themeKey = 'settings.theme';

  final SharedPreferences _preferences;

  @override
  AppSettings read() {
    return AppSettings(
      language: _parseLanguage(_preferences.getString(_languageKey)),
      theme: _parseTheme(_preferences.getString(_themeKey)),
    );
  }

  @override
  Future<void> write(AppSettings settings) async {
    await _preferences.setString(_languageKey, settings.language.name);
    await _preferences.setString(_themeKey, settings.theme.name);
  }

  AppLanguage _parseLanguage(String? value) {
    return AppLanguage.values.firstWhere(
      (language) => language.name == value,
      orElse: () => AppLanguage.system,
    );
  }

  AppThemePreference _parseTheme(String? value) {
    return AppThemePreference.values.firstWhere(
      (theme) => theme.name == value,
      orElse: () => AppThemePreference.system,
    );
  }
}
