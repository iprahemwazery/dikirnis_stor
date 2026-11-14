import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/l10n.dart';
import '../../domain/entities/offer.dart';

String formatOfferAmount(BuildContext context, double value) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return NumberFormat.decimalPattern(locale).format(value);
}

String formatOfferPrice(BuildContext context, double value) {
  return '${formatOfferAmount(context, value)} ${context.l10n.currencyEgp}';
}

class OfferPrice extends StatelessWidget {
  const OfferPrice({super.key, required this.offer, this.compact = false});

  final Offer offer;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            formatOfferPrice(context, offer.price),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(
              color: colorScheme.primary,
              fontSize: compact ? 13 : 15,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
        ),
        if (offer.hasOriginalPrice) ...[
          const SizedBox(width: 5),
          Flexible(
            child: Tooltip(
              message: context.l10n.offerDetailsOriginalPriceLabel,
              child: Text(
                formatOfferPrice(context, offer.originalPrice!),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: compact ? 9 : 10,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: colorScheme.onSurfaceVariant,
                  height: 1.1,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
