import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../router/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';
import '../../../categories/domain/entities/service_category.dart';
import '../../../home/presentation/widgets/home_bottom_navigation_bar.dart';
import '../../../home/presentation/widgets/home_search_bar.dart';
import '../../../home/presentation/widgets/home_section_header.dart';
import '../../domain/entities/offer.dart';
import '../cubit/offers_cubit.dart';
import '../cubit/offers_state.dart';
import '../widgets/offer_category_chips.dart';
import '../widgets/offers_sort_sheet.dart';
import '../widgets/product_card.dart';
import '../widgets/product_grid_loading_view.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

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
        toolbarHeight: 82,
        centerTitle: false,
        titleSpacing: AppSpacing.md,
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.marketplaceTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                color: headingColor,
                fontWeight: FontWeight.w900,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              l10n.marketplaceSubtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const ValueKey('marketplace_sell_product'),
        onPressed: () => _showSellUnavailable(context),
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        elevation: 3,
        extendedPadding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          0,
        ),
        icon: const Icon(Icons.add_business_rounded, size: 20),
        label: Text(
          l10n.offersSellProduct,
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: BlocListener<OffersCubit, OffersState>(
          listenWhen: (previous, current) =>
              current.favoriteFailure != null &&
              previous.favoriteFailure != current.favoriteFailure,
          listener: (context, state) {
            _showMessage(context, l10n.offersFavoriteError);
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lg,
                  AppSpacing.xs,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: HomeSearchBar(
                        hintText: l10n.marketplaceSearchHint,
                        onChanged: (query) =>
                            context.read<OffersCubit>().search(query),
                        onSubmitted: (query) =>
                            context.read<OffersCubit>().search(query),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    _SortButton(
                      onTap: () async {
                        final cubit = context.read<OffersCubit>();
                        final selectedSort = await showOffersSortSheet(
                          context,
                          selectedSort: cubit.state.sort,
                        );
                        if (selectedSort != null) {
                          cubit.selectSort(selectedSort);
                        }
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<OffersCubit, OffersState>(
                buildWhen: (previous, current) =>
                    previous.categories != current.categories ||
                    previous.selectedCategoryId != current.selectedCategoryId,
                builder: (context, state) {
                  if (state.categories.isEmpty) {
                    return const SizedBox(height: 42);
                  }
                  return OfferCategoryChips(
                    categories: state.categories,
                    selectedCategoryId: state.selectedCategoryId,
                    onSelected: (categoryId) =>
                        context.read<OffersCubit>().selectCategory(categoryId),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xs),
              Expanded(
                child: BlocBuilder<OffersCubit, OffersState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.offers != current.offers ||
                      previous.categories != current.categories ||
                      previous.favoriteIds != current.favoriteIds ||
                      previous.query != current.query ||
                      previous.sort != current.sort,
                  builder: (context, state) {
                    return switch (state.status) {
                      OffersStatus.initial ||
                      OffersStatus.loading => const ProductGridLoadingView(),
                      OffersStatus.failure => AppErrorState(
                        message: l10n.marketplaceErrorMessage,
                        retryLabel: l10n.retry,
                        onRetry: () =>
                            context.read<OffersCubit>().load(force: true),
                      ),
                      OffersStatus.success || OffersStatus.empty =>
                        _ProductsGrid(state: state, headingColor: headingColor),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        selectedIndex: 2,
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
            return;
          }
          if (index == 3) {
            context.go(AppRoutes.offers);
            return;
          }
          if (index == 4) {
            context.go(AppRoutes.profile);
            return;
          }
          _showMessage(context, l10n.comingSoonMessage);
        },
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Tooltip(
      message: context.l10n.offersSortTooltip,
      child: Material(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.xl),
          side: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: const ValueKey('marketplace_sort_button'),
          onTap: onTap,
          child: SizedBox.square(
            dimension: 56,
            child: Icon(
              Icons.tune_rounded,
              color: colorScheme.primary,
              size: 23,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid({required this.state, required this.headingColor});

  final OffersState state;
  final Color headingColor;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final categoriesById = <String, ServiceCategory>{
      for (final category in state.categories) category.id: category,
    };

    return RefreshIndicator(
      onRefresh: context.read<OffersCubit>().refresh,
      color: Theme.of(context).colorScheme.primary,
      child: CustomScrollView(
        key: const PageStorageKey<String>('marketplace_product_grid'),
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: HomeSectionHeader(
              title: l10n.marketplaceSectionTitle,
              topPadding: AppSpacing.xs,
              showAccent: true,
              titleColor: headingColor,
            ),
          ),
          if (state.offers.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: AppEmptyState(
                message: state.isSearching
                    ? l10n.marketplaceNoSearchResults
                    : l10n.marketplaceEmptyMessage,
                icon: state.isSearching
                    ? Icons.search_off_rounded
                    : Icons.shopping_bag_outlined,
              ),
            )
          else
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  110,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final columnCount = (constraints.maxWidth / 200)
                        .floor()
                        .clamp(2, 4);
                    final columns = List.generate(
                      columnCount,
                      (_) => <Widget>[],
                    );

                    for (var index = 0; index < state.offers.length; index++) {
                      final offer = state.offers[index];
                      final category = categoriesById[offer.categoryId];
                      columns[index % columnCount].add(
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: ProductCard(
                            offer: offer,
                            categoryName: category?.localizedName(languageCode),
                            isFavorite: state.isFavorite(offer.id),
                            onTap: () => _openOffer(context, offer),
                            onFavoriteTap: () => context
                                .read<OffersCubit>()
                                .toggleFavorite(offer.id),
                          ),
                        ),
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var index = 0; index < columnCount; index++) ...[
                          if (index > 0) const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: columns[index],
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _openOffer(BuildContext context, Offer offer) {
    context.push(AppRoutes.productDetailsPath(offer.id));
  }
}

Future<void> _showSellUnavailable(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      final theme = Theme.of(sheetContext);
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
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.promoOrange,
                  borderRadius: BorderRadius.circular(AppRadii.xl),
                ),
                child: const Icon(
                  Icons.add_business_outlined,
                  color: AppColors.promoOrangeAccent,
                  size: 34,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                sheetContext.l10n.offersSellProduct,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                sheetContext.l10n.offersSellUnavailable,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  child: Text(sheetContext.l10n.ok),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showMessage(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
