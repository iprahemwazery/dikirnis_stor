import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../l10n/l10n.dart';
import '../../../../router/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/offer.dart';
import '../cubit/offer_details_cubit.dart';
import '../cubit/offer_details_state.dart';
import '../widgets/offer_ai_guidance_card.dart';
import '../widgets/offer_bottom_action_bar.dart';
import '../widgets/offer_comments_section.dart';
import '../widgets/offer_image_gallery.dart';
import '../widgets/offer_price.dart';
import '../widgets/offer_seller_card.dart';
import '../widgets/offer_similar_products.dart';
import '../widgets/offer_summary_section.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.offerId});

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
                context.l10n.productDetailsTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: headingColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              actions: [
                if (offer != null) ...[
                  IconButton(
                    tooltip: context.l10n.offerShareTooltip,
                    onPressed: () => _shareOffer(context, offer),
                    icon: Icon(
                      Icons.share_outlined,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
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
                      ? context.l10n.productDetailsNotFound
                      : context.l10n.marketplaceErrorMessage,
                  retryLabel: context.l10n.retry,
                  onRetry: context.read<OfferDetailsCubit>().retry,
                ),
                OfferDetailsStatus.success =>
                  offer == null
                      ? const AppLoading()
                      : _ProductDetailsContent(
                          offer: offer,
                          state: state,
                          headingColor: headingColor,
                        ),
              },
            ),
            bottomNavigationBar:
                state.status == OfferDetailsStatus.success && offer != null
                ? OfferBottomActionBar(
                    offer: offer,
                    onCall: () => _contactSeller(context, offer),
                    onWhatsApp: () => _contactSeller(context, offer),
                    onOrder: () => _showOrderUnavailable(context),
                  )
                : null,
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
    context.go(AppRoutes.marketplace);
  }
}

class _ProductDetailsContent extends StatelessWidget {
  const _ProductDetailsContent({
    required this.offer,
    required this.state,
    required this.headingColor,
  });

  final Offer offer;
  final OfferDetailsState state;
  final Color headingColor;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final cubit = context.read<OfferDetailsCubit>();

    return ListView(
      padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.lg),
      children: [
        OfferImageGallery(offer: offer),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
          ),
          child: OfferSummarySection(
            offer: offer,
            categoryName: state.category?.localizedName(languageCode),
            headingColor: headingColor,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
          ),
          child: OfferSellerCard(
            seller: offer.seller,
            headingColor: headingColor,
            onCall: () => _contactSeller(context, offer),
            onWhatsApp: () => _contactSeller(context, offer),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
          ),
          child: OfferAiGuidanceCard(offer: offer),
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
          ),
          child: OfferCommentsSection(
            comments: offer.comments,
            headingColor: headingColor,
          ),
        ),
        if (state.similarOffers.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
            ),
            child: OfferSimilarProducts(
              offers: state.similarOffers,
              isFavorite: state.isFavoriteFor,
              onOpen: (similarOffer) =>
                  context.push(AppRoutes.productDetailsPath(similarOffer.id)),
              onFavoriteTap: (similarOffer) =>
                  cubit.toggleFavoriteFor(similarOffer.id),
            ),
          ),
        ],
      ],
    );
  }
}

Future<void> _shareOffer(BuildContext context, Offer offer) async {
  final text =
      '${offer.title}\n'
      '${offer.businessName}\n'
      '${formatOfferPrice(context, offer.price)}\n'
      '${offer.description}';
  await Clipboard.setData(ClipboardData(text: text));
  if (!context.mounted) {
    return;
  }
  _showMessage(context, context.l10n.offerShareCopied);
}

void _contactSeller(BuildContext context, Offer offer) {
  final phone = offer.seller.phone?.trim();
  if (phone == null || phone.isEmpty) {
    _showMessage(context, context.l10n.offerContactUnavailable);
    return;
  }
  Clipboard.setData(ClipboardData(text: phone));
  _showMessage(context, context.l10n.offerContactCopied);
}

Future<void> _showOrderUnavailable(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xl)),
    ),
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
                  Icons.shopping_bag_outlined,
                  color: AppColors.promoOrangeAccent,
                  size: 34,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                sheetContext.l10n.offerOrderUnavailableTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                sheetContext.l10n.offerOrderUnavailableMessage,
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
