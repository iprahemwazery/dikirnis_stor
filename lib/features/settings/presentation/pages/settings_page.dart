import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/app_settings.dart';
import '../cubit/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final headingColor = isDark
        ? theme.colorScheme.onSurface
        : AppColors.darkTeal;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          l10n.settingsTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            color: headingColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<SettingsCubit, AppSettings>(
          builder: (context, settings) {
            return ListView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              children: [
                _SettingsSectionTitle(
                  title: l10n.settingsAppearanceSection,
                  color: headingColor,
                ),
                _SettingsCard(
                  children: [
                    _SettingsChoiceTile(
                      tileKey: const ValueKey('settings_theme_system'),
                      icon: Icons.brightness_auto_outlined,
                      title: l10n.settingsThemeSystem,
                      selected: settings.theme == AppThemePreference.system,
                      onTap: () => _save(
                        context,
                        () => context.read<SettingsCubit>().setTheme(
                          AppThemePreference.system,
                        ),
                      ),
                    ),
                    _SettingsChoiceTile(
                      tileKey: const ValueKey('settings_theme_light'),
                      icon: Icons.light_mode_outlined,
                      title: l10n.settingsThemeLight,
                      selected: settings.theme == AppThemePreference.light,
                      onTap: () => _save(
                        context,
                        () => context.read<SettingsCubit>().setTheme(
                          AppThemePreference.light,
                        ),
                      ),
                    ),
                    _SettingsChoiceTile(
                      tileKey: const ValueKey('settings_theme_dark'),
                      icon: Icons.dark_mode_outlined,
                      title: l10n.settingsThemeDark,
                      selected: settings.theme == AppThemePreference.dark,
                      onTap: () => _save(
                        context,
                        () => context.read<SettingsCubit>().setTheme(
                          AppThemePreference.dark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                _SettingsSectionTitle(
                  title: l10n.settingsLanguageSection,
                  color: headingColor,
                ),
                _SettingsCard(
                  children: [
                    _SettingsChoiceTile(
                      tileKey: const ValueKey('settings_language_system'),
                      icon: Icons.language_rounded,
                      title: l10n.settingsLanguageSystem,
                      selected: settings.language == AppLanguage.system,
                      onTap: () => _save(
                        context,
                        () => context.read<SettingsCubit>().setLanguage(
                          AppLanguage.system,
                        ),
                      ),
                    ),
                    _SettingsChoiceTile(
                      tileKey: const ValueKey('settings_language_arabic'),
                      icon: Icons.translate_rounded,
                      title: l10n.settingsLanguageArabic,
                      selected: settings.language == AppLanguage.arabic,
                      onTap: () => _save(
                        context,
                        () => context.read<SettingsCubit>().setLanguage(
                          AppLanguage.arabic,
                        ),
                      ),
                    ),
                    _SettingsChoiceTile(
                      tileKey: const ValueKey('settings_language_english'),
                      icon: Icons.translate_rounded,
                      title: l10n.settingsLanguageEnglish,
                      selected: settings.language == AppLanguage.english,
                      onTap: () => _save(
                        context,
                        () => context.read<SettingsCubit>().setLanguage(
                          AppLanguage.english,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.settingsOfflineNote,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _save(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(context.l10n.settingsSaveError)));
    }
  }
}

class _SettingsSectionTitle extends StatelessWidget {
  const _SettingsSectionTitle({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.xs,
        bottom: AppSpacing.xs,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            for (var index = 0; index < children.length; index++) ...[
              children[index],
              if (index < children.length - 1)
                const Divider(height: 1, indent: AppSpacing.md),
            ],
          ],
        ),
      ),
    );
  }
}

class _SettingsChoiceTile extends StatelessWidget {
  const _SettingsChoiceTile({
    required this.tileKey,
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final Key tileKey;
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Semantics(
      selected: selected,
      button: true,
      child: ListTile(
        key: tileKey,
        onTap: onTap,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.md,
          AppSpacing.xs,
          AppSpacing.md,
          AppSpacing.xs,
        ),
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: Icon(
          selected
              ? Icons.check_circle_rounded
              : Icons.radio_button_unchecked_rounded,
          color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
