abstract final class AppRoutes {
  static const String home = '/';
  static const String explore = '/explore';
  static const String offers = '/offers';
  static const String offerDetails = '$offers/:offerId';
  static const String marketplace = '/marketplace';
  static const String productDetails = '$marketplace/:offerId';
  static const String profile = '/profile';
  static const String settings = '$profile/settings';

  static String offerDetailsPath(String offerId) {
    return '$offers/${Uri.encodeComponent(offerId)}';
  }

  static String productDetailsPath(String offerId) {
    return '$marketplace/${Uri.encodeComponent(offerId)}';
  }
}
