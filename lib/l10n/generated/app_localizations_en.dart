// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Dikirnis Store';

  @override
  String get homeHeadline => 'Local services, close to home';

  @override
  String get homeSubtitle => 'Discover trusted services and shops in Dikirnis.';

  @override
  String get locationLabel => 'Dikirnis, Dakahlia';

  @override
  String get searchHint => 'Search for a service';

  @override
  String get categoriesTitle => 'Browse categories';

  @override
  String providersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count providers',
      one: '1 provider',
      zero: 'No providers',
    );
    return '$_temp0';
  }

  @override
  String get retry => 'Try again';

  @override
  String get categoriesErrorMessage =>
      'We could not load the categories. Please try again.';

  @override
  String get emptyCategoriesMessage => 'No categories are available yet.';

  @override
  String get noSearchResults => 'No services match your search.';

  @override
  String get pageNotFoundTitle => 'Page not found';

  @override
  String get pageNotFoundMessage =>
      'The page you are looking for does not exist or has moved.';

  @override
  String get backToHome => 'Back to home';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get goodEvening => 'Good evening';

  @override
  String get homeSearchHint => 'Search for a restaurant, doctor, shop...';

  @override
  String get notificationsLabel => 'Notifications';

  @override
  String get messagesLabel => 'Messages';

  @override
  String get homeCategoriesTitle => 'Categories';

  @override
  String get mostViewedTitle => 'Most viewed this week';

  @override
  String get recentlyAddedTitle => 'Recently added';

  @override
  String get medicalSectorTitle => 'Medical sector';

  @override
  String get restaurantsCafesTitle => 'Restaurants & cafes';

  @override
  String get viewAll => 'View all';

  @override
  String get moreLabel => 'More';

  @override
  String get newBadge => 'New';

  @override
  String get verifiedBadge => 'Verified';

  @override
  String get sponsoredBadge => 'Sponsored';

  @override
  String get viewsLabel => 'views';

  @override
  String get navHome => 'Home';

  @override
  String get navExplore => 'Explore';

  @override
  String get navMarketplace => 'Marketplace';

  @override
  String get navOffers => 'Offers';

  @override
  String get navProfile => 'Profile';

  @override
  String get comingSoonMessage => 'This feature will be available soon.';

  @override
  String get searchComingSoonMessage => 'Full directory search is coming soon.';

  @override
  String get homeErrorMessage =>
      'We could not load the home page. Please try again.';

  @override
  String get homeEmptyMessage => 'There is nothing to show right now.';

  @override
  String get advertisementCloseLabel => 'Dismiss advertisement';

  @override
  String get advertisementActionLabel => 'Open advertisement';

  @override
  String get exploreTitle => 'Categories';

  @override
  String get allCategoriesTitle => 'All categories';

  @override
  String subcategoriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count subcategories',
      one: '1 subcategory',
      zero: 'No subcategories',
    );
    return '$_temp0';
  }

  @override
  String get promoOffersTitle => 'Offers';

  @override
  String get promoOffersDescription =>
      'Discover the best offers and discounts...';

  @override
  String get promoNewsTitle => 'News';

  @override
  String get promoNewsDescription => 'Follow the latest local and global news';

  @override
  String get promoMarketTitle => 'Market prices';

  @override
  String get promoMarketDescription => 'Prices of vegetables, meat and goods';

  @override
  String get promoJobsTitle => 'Jobs';

  @override
  String get promoJobsDescription => 'Browse open jobs and apply...';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileEditProfile => 'Edit profile';

  @override
  String profileMemberSince(String year) {
    return 'Member since $year';
  }

  @override
  String get profileOrdersStat => 'Orders';

  @override
  String get profileFavoritesStat => 'Favorites';

  @override
  String get profileReviewsStat => 'Reviews';

  @override
  String get profileAccountSection => 'Account';

  @override
  String get profilePersonalInfo => 'Personal information';

  @override
  String get profileMyOrders => 'My orders';

  @override
  String get profileFavorites => 'Favorites';

  @override
  String get profileAddresses => 'My addresses';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileActivitySection => 'My activity';

  @override
  String get profileMyProfessionalFiles => 'My professional files';

  @override
  String get profileMyListings => 'My listings';

  @override
  String get profileMyReviews => 'My reviews';

  @override
  String get profileSupportSection => 'Support';

  @override
  String get profileHelpCenter => 'Help center';

  @override
  String get profileContactUs => 'Contact us';

  @override
  String get profileFaq => 'FAQ';

  @override
  String get profilePrivacyPolicy => 'Privacy policy';

  @override
  String get profileTerms => 'Terms and conditions';

  @override
  String get profileEmergencyTitle => 'In case of emergency';

  @override
  String get profileEmergencySubtitle =>
      'Important emergency numbers available around the clock';

  @override
  String get profileEmergencySheetTitle => 'Emergency numbers';

  @override
  String get profileEmergencyNote => 'Direct calling will be available soon.';

  @override
  String get profileEmergencyAmbulance => 'Ambulance';

  @override
  String get profileEmergencyPolice => 'Police';

  @override
  String get profileEmergencyFire => 'Fire department';

  @override
  String get profileLogout => 'Log out';

  @override
  String get profileLogoutConfirmTitle => 'Log out';

  @override
  String get profileLogoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get profileLogoutUnavailable =>
      'There is no active session to log out of.';

  @override
  String get cancel => 'Cancel';

  @override
  String get profileErrorMessage =>
      'We could not load your profile. Please try again.';

  @override
  String get offersTitle => 'Dikirnis Offers 🎁';

  @override
  String get offersSubtitle =>
      'The best products and offers from Dikirnis stores';

  @override
  String get offersSearchHint => 'Search offers...';

  @override
  String get offersAllCategory => 'All';

  @override
  String get offersSectionTitle => 'All offers';

  @override
  String get offersEmptyMessage => 'There are no offers available right now.';

  @override
  String get offersNoSearchResults => 'No offers match your search.';

  @override
  String get offersErrorMessage =>
      'We could not load the offers. Please try again.';

  @override
  String get marketplaceTitle => 'Dikirnis Marketplace';

  @override
  String get marketplaceSubtitle =>
      'The best products and offers from Dikirnis stores';

  @override
  String get marketplaceSearchHint => 'Search products or offers...';

  @override
  String get marketplaceSectionTitle => 'Products & offers';

  @override
  String get marketplaceEmptyMessage =>
      'There are no products available right now.';

  @override
  String get marketplaceNoSearchResults => 'No products match your search.';

  @override
  String get marketplaceErrorMessage =>
      'We could not load the products. Please try again.';

  @override
  String get offersFeaturedBadge => 'Featured';

  @override
  String offersDiscountValue(int percent) {
    return '$percent% off';
  }

  @override
  String offersExpiresOn(String date) {
    return 'Ends $date';
  }

  @override
  String get offersAddFavorite => 'Add to favorites';

  @override
  String get offersRemoveFavorite => 'Remove from favorites';

  @override
  String get offersFavoriteError =>
      'We could not update favorites. Please try again.';

  @override
  String get offersSortTooltip => 'Sort results';

  @override
  String get offersSortTitle => 'Sort results';

  @override
  String get offersSortRecommended => 'Recommended';

  @override
  String get offersSortPriceLow => 'Lowest price';

  @override
  String get offersSortPriceHigh => 'Highest price';

  @override
  String get offersSortHighestDiscount => 'Biggest discount';

  @override
  String get offersSortMostViewed => 'Most viewed';

  @override
  String get offersSellProduct => 'Sell a product';

  @override
  String get offersSellUnavailable =>
      'Selling products will be available after the publishing service is connected.';

  @override
  String get offerDetailsTitle => 'Offer details';

  @override
  String get offerDetailsDescriptionTitle => 'About the offer';

  @override
  String get offerDetailsNotFound => 'This offer could not be found.';

  @override
  String get productDetailsTitle => 'Product details';

  @override
  String get productDetailsDescriptionTitle => 'Product description';

  @override
  String get productDetailsNotFound => 'This product could not be found.';

  @override
  String get offerDetailsSave => 'Add to favorites';

  @override
  String get offerDetailsSaved => 'Added to favorites';

  @override
  String get offerDetailsDiscountLabel => 'Discount';

  @override
  String get offerDetailsExpiryLabel => 'Ends';

  @override
  String get offerDetailsViewsLabel => 'Views';

  @override
  String offerDetailsPublishedLabel(String date) {
    return 'Published $date';
  }

  @override
  String get offerDetailsAvailabilityLabel => 'Availability';

  @override
  String get offerDetailsAvailable => 'Available';

  @override
  String get offerDetailsUnavailable => 'Unavailable';

  @override
  String get offerDetailsOriginalPriceLabel => 'Price before discount';

  @override
  String offerGalleryCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get offerShareTooltip => 'Copy product information';

  @override
  String get offerShareCopied => 'Product information copied.';

  @override
  String get offerSellerTitle => 'Seller information';

  @override
  String get offerSellerVerified => 'Verified seller';

  @override
  String offerSellerMemberSince(String year) {
    return 'Member since $year';
  }

  @override
  String get offerContactCall => 'Call';

  @override
  String get offerContactWhatsapp => 'WhatsApp';

  @override
  String get offerContactUnavailable => 'Contact number is unavailable.';

  @override
  String get offerContactCopied => 'Contact number copied.';

  @override
  String get offerCommentsTitle => 'Comments';

  @override
  String get offerCommentsEmpty => 'No comments yet.';

  @override
  String get offerCommentHint => 'Add a comment...';

  @override
  String get offerCommentSend => 'Send';

  @override
  String get offerCommentEmptyError => 'Write a comment first.';

  @override
  String get offerCommentUnavailable =>
      'Adding comments is unavailable until the comments service is connected.';

  @override
  String get offerAiTitle => 'Smart guidance';

  @override
  String get offerAiPreviewNote =>
      'Local preview — the recommendation service is not connected yet.';

  @override
  String get offerAiStrongDiscount =>
      'This offer has a strong discount. Review the expiry date and seller details before ordering.';

  @override
  String get offerAiCompare =>
      'Compare this offer with similar products and confirm your needs before ordering.';

  @override
  String get offerSimilarTitle => 'Similar products';

  @override
  String get offerOrderNow => 'Order now';

  @override
  String get offerOrderUnavailableTitle => 'Ordering unavailable';

  @override
  String get offerOrderUnavailableMessage =>
      'The ordering service is not connected yet, and no order was submitted.';

  @override
  String get currencyEgp => 'EGP';

  @override
  String get ok => 'OK';
}
