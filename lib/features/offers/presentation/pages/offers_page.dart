import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../router/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../home/presentation/widgets/home_search_bar.dart';
import '../../../home/presentation/widgets/home_section_header.dart';
import '../../domain/entities/offer.dart';
import '../cubit/offers_cubit.dart';
import '../cubit/offers_state.dart';
import '../widgets/offer_card.dart';
import '../widgets/offer_category_chips.dart';
import '../widgets/offers_loading_view.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

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
          l10n.offersTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            color: headingColor,
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
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: HomeSearchBar(
                  hintText: l10n.offersSearchHint,
                  onChanged: (query) =>
                      context.read<OffersCubit>().search(query),
                  onSubmitted: (query) =>
                      context.read<OffersCubit>().search(query),
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
                      previous.favoriteIds != current.favoriteIds ||
                      previous.query != current.query,
                  builder: (context, state) {
                    return switch (state.status) {
                      OffersStatus.initial ||
                      OffersStatus.loading => const OffersLoadingView(),
                      OffersStatus.failure => AppErrorState(
                        message: l10n.offersErrorMessage,
                        retryLabel: l10n.retry,
                        onRetry: () =>
                            context.read<OffersCubit>().load(force: true),
                      ),
                      OffersStatus.success || OffersStatus.empty => _OffersList(
                        state: state,
                        headingColor: headingColor,
                      ),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OffersList extends StatelessWidget {
  const _OffersList({required this.state, required this.headingColor});

  final OffersState state;
  final Color headingColor;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return RefreshIndicator(
      onRefresh: context.read<OffersCubit>().refresh,
      color: Theme.of(context).colorScheme.primary,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: HomeSectionHeader(
              title: l10n.offersSectionTitle,
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
                    ? l10n.offersNoSearchResults
                    : l10n.offersEmptyMessage,
                icon: state.isSearching
                    ? Icons.search_off_rounded
                    : Icons.local_offer_outlined,
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              sliver: SliverList.builder(
                itemCount: state.offers.length,
                itemBuilder: (context, index) {
                  final offer = state.offers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: OfferCard(
                      offer: offer,
                      isFavorite: state.isFavorite(offer.id),
                      onTap: () => _openOffer(context, offer),
                      onFavoriteTap: () =>
                          context.read<OffersCubit>().toggleFavorite(offer.id),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _openOffer(BuildContext context, Offer offer) {
    context.push(AppRoutes.offerDetailsPath(offer.id));
  }
}

void _showMessage(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
