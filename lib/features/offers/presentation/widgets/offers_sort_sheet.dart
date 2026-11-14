import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../theme/app_radii.dart';
import '../../../../theme/app_spacing.dart';
import '../cubit/offers_state.dart';

Future<OffersSort?> showOffersSortSheet(
  BuildContext context, {
  required OffersSort selectedSort,
}) {
  return showModalBottomSheet<OffersSort>(
    context: context,
    showDragHandle: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xl)),
    ),
    builder: (sheetContext) {
      return _OffersSortSheet(selectedSort: selectedSort);
    },
  );
}

class _OffersSortSheet extends StatelessWidget {
  const _OffersSortSheet({required this.selectedSort});

  final OffersSort selectedSort;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final options = <(OffersSort, String, IconData)>[
      (
        OffersSort.recommended,
        l10n.offersSortRecommended,
        Icons.auto_awesome_rounded,
      ),
      (OffersSort.priceLowHigh, l10n.offersSortPriceLow, Icons.south_rounded),
      (OffersSort.priceHighLow, l10n.offersSortPriceHigh, Icons.north_rounded),
      (
        OffersSort.highestDiscount,
        l10n.offersSortHighestDiscount,
        Icons.local_offer_outlined,
      ),
      (
        OffersSort.mostViewed,
        l10n.offersSortMostViewed,
        Icons.visibility_outlined,
      ),
    ];

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.offersSortTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            for (final (sort, label, icon) in options)
              ListTile(
                key: ValueKey('offer_sort_${sort.name}'),
                contentPadding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.xs,
                ),
                leading: Icon(icon, color: colorScheme.primary),
                title: Text(label),
                trailing: sort == selectedSort
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: colorScheme.primary,
                      )
                    : null,
                onTap: () => Navigator.of(context).pop(sort),
              ),
          ],
        ),
      ),
    );
  }
}
