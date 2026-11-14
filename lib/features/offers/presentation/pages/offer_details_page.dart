import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/widgets/app_asset_image.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../l10n/l10n.dart';
import '../../../../router/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_shadows.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/offer.dart';
import '../cubit/offer_details_cubit.dart';
import '../cubit/offer_details_state.dart';
import '../widgets/offer_badges.dart';

class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({super.key, required this.offerId});

  final String offerId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final headingColor = isDark
        ? theme.colorScheme.onSurface
        : AppColors.darkTeal;

    return BlocListener<OfferDetailsCubit, OfferDetailsState>(
      listenWhen: (previous, current) =>
          current.favoriteFailure != null &&
          previous.favoriteFailure != current.favoriteFailure,
      listener: (context, state) {
        _showMessage(context, context.l10n.offersFavoriteError);
      },
      child: BlocBuilder<OfferDetailsCubit, OfferDetailsState>(
        builder: (context, state) {
          final offer = state.offer;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.colorScheme.surface,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              leading: IconButton(
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                onPressed: () => _goBack(context),
                icon: Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? Icons.arrow_forward_rounded
                      : Icons.arrow_back_rounded,
                ),
              ),
              title: Text(
                context.l10n.offerDetailsTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: headingColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              actions: [
                if (offer != null)
                  IconButton(
                    tooltip: state.isFavorite
                        ? context.l10n.offersRemoveFavorite
                        : context.l10n.offersAddFavorite,
                    onPressed: () =>
                        context.read<OfferDetailsCubit>().toggleFavorite(),
                    icon: Icon(
                      state.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: state.isFavorite
                          ? const Color(0xFFE45757)
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
            body: SafeArea(
              top: false,
              bottom: false,
              child: switch (state.status) {
                OfferDetailsStatus.initial ||
                OfferDetailsStatus.loading => const AppLoading(),
                OfferDetailsStatus.failure => AppErrorState(
                  message: state.failure?.type == FailureType.notFound
                      ? context.l10n.offerDetailsNotFound
                      : context.l10n.offersErrorMessage,
                  retryLabel: context.l10n.retry,
                  onRetry: context.read<OfferDetailsCubit>().retry,
                ),
                OfferDetailsStatus.success =>
                  offer == null
                      ? const AppLoading()
                      : _OfferDetailsContent(
                          offer: offer,
                          isFavorite: state.isFavorite,
                          headingColor: headingColor,
                        ),
              },
            ),
          );
        },
      ),
    );
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(AppRoutes.offers);
  }
}

class _OfferDetailsContent extends StatelessWidget {
  const _OfferDetailsContent({
    required this.offer,
    required this.isFavorite,
    required this.headingColor,
  });

  final Offer offer;
  final bool isFavorite;
  final Color headingColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cubit = context.read<OfferDetailsCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.xl),
            child: SizedBox(
              height: 230,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppAssetImage(
                    assetPath: offer.image,
                    fit: BoxFit.cover,
                    semanticLabel: offer.businessName,
                    fallbackIcon: Icons.local_offer_outlined,
                    placeholder: Container(
                      color: AppColors.tealSoft,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.local_offer_outlined,
                        color: colorScheme.primary,
                        size: 34,
                      ),
                    ),
                  ),
                  if (offer.hasDiscount)
                    PositionedDirectional(
                      top: AppSpacing.sm,
                      start: AppSpacing.sm,
                      child: OfferDiscountBadge(
                        percent: offer.discountPercent!,
                      ),
                    ),
                  if (offer.isFeatured)
                    const PositionedDirectional(
                      top: AppSpacing.sm,
                      end: AppSpacing.sm,
                      child: OfferFeaturedBadge(),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            offer.businessName,
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            offer.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: headingColor,
              fontWeight: FontWeight.w800,
              height: 1.35,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _OfferInfoCard(offer: offer),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.l10n.offerDetailsDescriptionTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              color: headingColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            offer.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: isFavorite
                ? context.l10n.offerDetailsSaved
                : context.l10n.offerDetailsSave,
            icon: isFavorite
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            variant: isFavorite
                ? AppButtonVariant.outlined
                : AppButtonVariant.filled,
            onPressed: () => cubit.toggleFavorite(),
          ),
        ],
      ),
    );
  }
}

class _OfferInfoCard extends StatelessWidget {
  const _OfferInfoCard({required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final l10n = context.l10n;
    final rows = <Widget>[];

    if (offer.hasDiscount) {
      rows.add(
        _InfoRow(
          icon: Icons.local_offer_outlined,
          label: l10n.offerDetailsDiscountLabel,
          value: '${offer.discountPercent}%',
          valueColor: const Color(0xFFD84A4A),
        ),
      );
    }

    if (offer.expiresAt != null) {
      final date = MaterialLocalizations.of(
        context,
      ).formatMediumDate(offer.expiresAt!);
      rows.add(
        _InfoRow(
          icon: Icons.event_outlined,
          label: l10n.offerDetailsExpiryLabel,
          value: date,
        ),
      );
    }

    if (offer.views > 0) {
      rows.add(
        _InfoRow(
          icon: Icons.visibility_outlined,
          label: l10n.offerDetailsViewsLabel,
          value: '${offer.views}',
        ),
      );
    }

    if (rows.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.homeBorder,
        ),
        boxShadow: isDark ? const [] : AppShadows.card,
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        AppSpacing.xs,
      ),
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            rows[index],
            if (index < rows.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 18, color: colorScheme.primary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            textDirection: value.contains('%') ? TextDirection.ltr : null,
            style: theme.textTheme.titleSmall?.copyWith(
              color: valueColor ?? colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
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
