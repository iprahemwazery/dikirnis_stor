import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../domain/entities/offer.dart';
import 'product_card.dart';

class OfferSimilarProducts extends StatelessWidget {
  const OfferSimilarProducts({
    super.key,
    required this.offers,
    required this.isFavorite,
    required this.onOpen,
    required this.onFavoriteTap,
  });

  final List<Offer> offers;
  final bool Function(String offerId) isFavorite;
  final ValueChanged<Offer> onOpen;
  final ValueChanged<Offer> onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.offerSimilarTitle,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: offers.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final offer = offers[index];
              return SizedBox(
                width: 168,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ProductCard(
                    offer: offer,
                    isFavorite: isFavorite(offer.id),
                    compact: true,
                    onTap: () => onOpen(offer),
                    onFavoriteTap: () => onFavoriteTap(offer),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
