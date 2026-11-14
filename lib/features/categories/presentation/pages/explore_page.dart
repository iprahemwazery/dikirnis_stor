import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../home/presentation/widgets/home_section_header.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';
import '../widgets/categories_sliver.dart';
import '../widgets/explore_promo_card.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final headingColor = isDark ? colorScheme.onSurface : AppColors.darkTeal;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final promos = <_PromoSpec>[
      _PromoSpec(
        title: l10n.promoOffersTitle,
        description: l10n.promoOffersDescription,
        icon: Icons.local_offer_rounded,
        background: AppColors.promoOrange,
        borderColor: AppColors.promoOrangeBorder,
        accentColor: AppColors.promoOrangeAccent,
      ),
      _PromoSpec(
        title: l10n.promoNewsTitle,
        description: l10n.promoNewsDescription,
        icon: Icons.newspaper_rounded,
        background: AppColors.promoBlue,
        borderColor: AppColors.promoBlueBorder,
        accentColor: AppColors.promoBlueAccent,
      ),
      _PromoSpec(
        title: l10n.promoMarketTitle,
        description: l10n.promoMarketDescription,
        icon: Icons.shopping_cart_rounded,
        background: AppColors.promoGreen,
        borderColor: AppColors.promoGreenBorder,
        accentColor: AppColors.promoGreenAccent,
      ),
      _PromoSpec(
        title: l10n.promoJobsTitle,
        description: l10n.promoJobsDescription,
        icon: Icons.work_rounded,
        background: AppColors.promoPurple,
        borderColor: AppColors.promoPurpleBorder,
        accentColor: AppColors.promoPurpleAccent,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            final hasCategories =
                state.status == CategoriesStatus.success &&
                state.categories.isNotEmpty;

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: HomeSectionHeader(
                    title: l10n.allCategoriesTitle,
                    topPadding: AppSpacing.md,
                    showAccent: true,
                    titleColor: headingColor,
                  ),
                ),
                CategoriesSliver(
                  onCategoryTap: (_) => _showComingSoon(context),
                ),
                if (hasCategories) ...[
                  SliverToBoxAdapter(
                    child: HomeSectionHeader(
                      title: l10n.moreLabel,
                      showAccent: true,
                      titleColor: headingColor,
                    ),
                  ),
                  SliverLayoutBuilder(
                    builder: (context, constraints) {
                      const spacing = AppSpacing.sm;
                      final cellWidth =
                          (constraints.crossAxisExtent -
                              AppSpacing.lg * 2 -
                              spacing) /
                          2;
                      final textScale = MediaQuery.textScalerOf(
                        context,
                      ).scale(1);
                      final cardHeight =
                          (cellWidth.clamp(150.0, 175.0) + (textScale - 1) * 36)
                              .clamp(150.0, 230.0);

                      return SliverPadding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          AppSpacing.lg,
                          0,
                          AppSpacing.lg,
                          0,
                        ),
                        sliver: SliverGrid.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: spacing,
                                crossAxisSpacing: spacing,
                                mainAxisExtent: cardHeight,
                              ),
                          itemCount: promos.length,
                          itemBuilder: (context, index) {
                            final promo = promos[index];
                            return ExplorePromoCard(
                              key: ValueKey(promo.title),
                              title: promo.title,
                              description: promo.description,
                              icon: promo.icon,
                              background: promo.background,
                              borderColor: promo.borderColor,
                              accentColor: promo.accentColor,
                              onTap: () => _showComingSoon(context),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.xl),
                  ),
                ],
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        leading: IconButton(
          tooltip: l10n.backToHome,
          onPressed: () => StatefulNavigationShell.of(context).goBranch(0),
          icon: Icon(
            isRtl ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
          ),
        ),
        title: Text(
          l10n.exploreTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            color: headingColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

void _showComingSoon(BuildContext context) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(context.l10n.comingSoonMessage)));
}

class _PromoSpec {
  const _PromoSpec({
    required this.title,
    required this.description,
    required this.icon,
    required this.background,
    required this.borderColor,
    required this.accentColor,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color background;
  final Color borderColor;
  final Color accentColor;
}
