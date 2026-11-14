import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/di/injection.dart';
import '../features/settings/domain/entities/app_settings.dart';
import '../features/settings/presentation/cubit/settings_cubit.dart';
import '../l10n/l10n.dart';
import '../router/app_router.dart';
import '../theme/app_theme.dart';

class DikirnisApp extends StatelessWidget {
  const DikirnisApp({super.key, this.locale, this.themeMode, this.router});

  final Locale? locale;
  final ThemeMode? themeMode;
  final GoRouter? router;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>.value(
      value: getIt<SettingsCubit>(),
      child: BlocBuilder<SettingsCubit, AppSettings>(
        builder: (context, settings) {
          return MaterialApp.router(
            onGenerateTitle: (context) => context.l10n.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode ?? _themeModeFor(settings.theme),
            locale: locale ?? _localeFor(settings.language),
            routerConfig: router ?? appRouter,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }

  Locale? _localeFor(AppLanguage language) {
    return switch (language) {
      AppLanguage.system => null,
      AppLanguage.arabic => const Locale('ar'),
      AppLanguage.english => const Locale('en'),
    };
  }

  ThemeMode _themeModeFor(AppThemePreference theme) {
    return switch (theme) {
      AppThemePreference.system => ThemeMode.system,
      AppThemePreference.light => ThemeMode.light,
      AppThemePreference.dark => ThemeMode.dark,
    };
  }
}
