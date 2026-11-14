import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../l10n/l10n.dart';
import '../../../../router/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';
import '../../../home/presentation/widgets/home_bottom_navigation_bar.dart';
import '../../../home/presentation/widgets/home_section_header.dart';
import '../../domain/entities/user_profile.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_emergency_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_logout_button.dart';
import '../widgets/profile_menu_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return switch (state.status) {
              ProfileStatus.initial ||
              ProfileStatus.loading => const AppLoading(),
              ProfileStatus.failure => AppErrorState(
                message: l10n.profileErrorMessage,
                retryLabel: l10n.retry,
                onRetry: () => context.read<ProfileCubit>().load(force: true),
              ),
              ProfileStatus.success =>
                state.profile == null
                    ? const AppLoading()
                    : _ProfileContentView(profile: state.profile!),
            };
          },
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedIndex: 4,
        onDestinationSelected: (index) {
          if (index == 0) {
            context.go(AppRoutes.home);
            return;
          }
          if (index == 1) {
            context.go(AppRoutes.explore);
            return;
          }
          if (index == 2) {
            context.go(AppRoutes.marketplace);
            return;
          }
          if (index == 3) {
            context.go(AppRoutes.offers);
            return;
          }
          if (index == 4) {
            return;
          }
          _showMessage(context, l10n.comingSoonMessage);
        },
      ),
    );
  }
}

class _ProfileContentView extends StatelessWidget {
  const _ProfileContentView({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final headingColor = isDark
        ? theme.colorScheme.onSurface
        : AppColors.darkTeal;

    void showComingSoon() {
      _showMessage(context, l10n.comingSoonMessage);
    }

    Future<void> confirmLogout() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(l10n.profileLogoutConfirmTitle),
            content: Text(l10n.profileLogoutConfirmMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                ),
                child: Text(l10n.profileLogout),
              ),
            ],
          );
        },
      );

      if (confirmed != true || !context.mounted) {
        return;
      }
      _showMessage(context, l10n.profileLogoutUnavailable);
    }

    void showEmergencyNumbers() {
      showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (sheetContext) => const _EmergencyNumbersSheet(),
      );
    }

    return RefreshIndicator(
      onRefresh: context.read<ProfileCubit>().refresh,
      color: theme.colorScheme.primary,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: ProfileHeader(profile: profile, onEditTap: showComingSoon),
          ),
          SliverToBoxAdapter(
            child: HomeSectionHeader(
              title: l10n.profileAccountSection,
              topPadding: AppSpacing.lg,
              showAccent: true,
              titleColor: headingColor,
            ),
          ),
          SliverToBoxAdapter(
            child: ProfileMenuSection(
              items: [
                ProfileMenuItem(
                  icon: Icons.person_outline_rounded,
                  title: l10n.profilePersonalInfo,
                  onTap: showComingSoon,
                ),
                ProfileMenuItem(
                  icon: Icons.receipt_long_outlined,
                  title: l10n.profileMyOrders,
                  onTap: showComingSoon,
                ),
                ProfileMenuItem(
                  icon: Icons.favorite_border_rounded,
                  title: l10n.profileFavorites,
                  onTap: showComingSoon,
                ),
                ProfileMenuItem(
                  icon: Icons.location_on_outlined,
                  title: l10n.profileAddresses,
                  onTap: showComingSoon,
                ),
                ProfileMenuItem(
                  icon: Icons.settings_outlined,
                  title: l10n.profileSettings,
                  onTap: showComingSoon,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: HomeSectionHeader(
              title: l10n.profileActivitySection,
              showAccent: true,
              titleColor: headingColor,
            ),
          ),
          SliverToBoxAdapter(
            child: ProfileMenuSection(
              items: [
                ProfileMenuItem(
                  icon: Icons.work_outline_rounded,
                  title: l10n.profileMyProfessionalFiles,
                  onTap: showComingSoon,
                ),
                ProfileMenuItem(
                  icon: Icons.campaign_outlined,
                  title: l10n.profileMyListings,
                  onTap: showComingSoon,
                ),
                ProfileMenuItem(
                  icon: Icons.star_border_rounded,
                  title: l10n.profileMyReviews,
                  onTap: showComingSoon,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: HomeSectionHeader(
              title: l10n.profileSupportSection,
              showAccent: true,
              titleColor: headingColor,
            ),
          ),
          SliverToBoxAdapter(
            child: ProfileMenuSection(
              items: [
                ProfileMenuItem(
                  icon: Icons.help_outline_rounded,
                  title: l10n.profileHelpCenter,
                  onTap: showComingSoon,
                ),
                ProfileMenuItem(
                  icon: Icons.support_agent_rounded,
                  title: l10n.profileContactUs,
                  onTap: showComingSoon,
                ),
                ProfileMenuItem(
                  icon: Icons.quiz_outlined,
                  title: l10n.profileFaq,
                  onTap: showComingSoon,
                ),
                ProfileMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  title: l10n.profilePrivacyPolicy,
                  onTap: showComingSoon,
                ),
                ProfileMenuItem(
                  icon: Icons.description_outlined,
                  title: l10n.profileTerms,
                  onTap: showComingSoon,
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
          SliverToBoxAdapter(
            child: ProfileEmergencyCard(onTap: showEmergencyNumbers),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
          SliverToBoxAdapter(
            child: ProfileLogoutButton(onPressed: confirmLogout),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
        ],
      ),
    );
  }
}

class _EmergencyNumber {
  const _EmergencyNumber({
    required this.icon,
    required this.label,
    required this.number,
  });

  final IconData icon;
  final String label;
  final String number;
}

class _EmergencyNumbersSheet extends StatelessWidget {
  const _EmergencyNumbersSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;
    final numbers = [
      _EmergencyNumber(
        icon: Icons.emergency_rounded,
        label: l10n.profileEmergencyAmbulance,
        number: '123',
      ),
      _EmergencyNumber(
        icon: Icons.local_police_outlined,
        label: l10n.profileEmergencyPolice,
        number: '122',
      ),
      _EmergencyNumber(
        icon: Icons.local_fire_department_outlined,
        label: l10n.profileEmergencyFire,
        number: '180',
      ),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.profileEmergencySheetTitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.profileEmergencyNote,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final entry in numbers) ...[
              Container(
                margin: const EdgeInsetsDirectional.only(bottom: AppSpacing.xs),
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: Row(
                  children: [
                    Icon(entry.icon, color: colorScheme.error, size: 22),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        entry.label,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      entry.number,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.error,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
