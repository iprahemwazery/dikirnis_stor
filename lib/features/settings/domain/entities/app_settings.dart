import 'package:equatable/equatable.dart';

enum AppLanguage { system, arabic, english }

enum AppThemePreference { system, light, dark }

class AppSettings extends Equatable {
  const AppSettings({
    this.language = AppLanguage.system,
    this.theme = AppThemePreference.system,
  });

  final AppLanguage language;
  final AppThemePreference theme;

  AppSettings copyWith({AppLanguage? language, AppThemePreference? theme}) {
    return AppSettings(
      language: language ?? this.language,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object?> get props => [language, theme];
}
