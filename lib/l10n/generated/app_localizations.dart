import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Dikirnis Store'**
  String get appName;

  /// No description provided for @homeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Local services, close to home'**
  String get homeHeadline;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover trusted services and shops in Dikirnis.'**
  String get homeSubtitle;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Dikirnis, Dakahlia'**
  String get locationLabel;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a service'**
  String get searchHint;

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Browse categories'**
  String get categoriesTitle;

  /// Number of service providers listed in a category.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No providers} =1{1 provider} other{{count} providers}}'**
  String providersCount(int count);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @categoriesErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not load the categories. Please try again.'**
  String get categoriesErrorMessage;

  /// No description provided for @emptyCategoriesMessage.
  ///
  /// In en, this message translates to:
  /// **'No categories are available yet.'**
  String get emptyCategoriesMessage;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No services match your search.'**
  String get noSearchResults;

  /// No description provided for @pageNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFoundTitle;

  /// No description provided for @pageNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'The page you are looking for does not exist or has moved.'**
  String get pageNotFoundMessage;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a restaurant, doctor, shop...'**
  String get homeSearchHint;

  /// No description provided for @notificationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsLabel;

  /// No description provided for @messagesLabel.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesLabel;

  /// No description provided for @homeCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get homeCategoriesTitle;

  /// No description provided for @mostViewedTitle.
  ///
  /// In en, this message translates to:
  /// **'Most viewed this week'**
  String get mostViewedTitle;

  /// No description provided for @recentlyAddedTitle.
  ///
  /// In en, this message translates to:
  /// **'Recently added'**
  String get recentlyAddedTitle;

  /// No description provided for @medicalSectorTitle.
  ///
  /// In en, this message translates to:
  /// **'Medical sector'**
  String get medicalSectorTitle;

  /// No description provided for @restaurantsCafesTitle.
  ///
  /// In en, this message translates to:
  /// **'Restaurants & cafes'**
  String get restaurantsCafesTitle;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @moreLabel.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreLabel;

  /// No description provided for @newBadge.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newBadge;

  /// No description provided for @verifiedBadge.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verifiedBadge;

  /// No description provided for @sponsoredBadge.
  ///
  /// In en, this message translates to:
  /// **'Sponsored'**
  String get sponsoredBadge;

  /// No description provided for @viewsLabel.
  ///
  /// In en, this message translates to:
  /// **'views'**
  String get viewsLabel;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get navExplore;

  /// No description provided for @navMarketplace.
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get navMarketplace;

  /// No description provided for @navOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get navOffers;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @comingSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'This feature will be available soon.'**
  String get comingSoonMessage;

  /// No description provided for @searchComingSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'Full directory search is coming soon.'**
  String get searchComingSoonMessage;

  /// No description provided for @homeErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not load the home page. Please try again.'**
  String get homeErrorMessage;

  /// No description provided for @homeEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to show right now.'**
  String get homeEmptyMessage;

  /// No description provided for @advertisementCloseLabel.
  ///
  /// In en, this message translates to:
  /// **'Dismiss advertisement'**
  String get advertisementCloseLabel;

  /// No description provided for @advertisementActionLabel.
  ///
  /// In en, this message translates to:
  /// **'Open advertisement'**
  String get advertisementActionLabel;

  /// No description provided for @exploreTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get exploreTitle;

  /// No description provided for @allCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'All categories'**
  String get allCategoriesTitle;

  /// Number of subcategories listed in a category.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No subcategories} =1{1 subcategory} other{{count} subcategories}}'**
  String subcategoriesCount(int count);

  /// No description provided for @promoOffersTitle.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get promoOffersTitle;

  /// No description provided for @promoOffersDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover the best offers and discounts...'**
  String get promoOffersDescription;

  /// No description provided for @promoNewsTitle.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get promoNewsTitle;

  /// No description provided for @promoNewsDescription.
  ///
  /// In en, this message translates to:
  /// **'Follow the latest local and global news'**
  String get promoNewsDescription;

  /// No description provided for @promoMarketTitle.
  ///
  /// In en, this message translates to:
  /// **'Market prices'**
  String get promoMarketTitle;

  /// No description provided for @promoMarketDescription.
  ///
  /// In en, this message translates to:
  /// **'Prices of vegetables, meat and goods'**
  String get promoMarketDescription;

  /// No description provided for @promoJobsTitle.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get promoJobsTitle;

  /// No description provided for @promoJobsDescription.
  ///
  /// In en, this message translates to:
  /// **'Browse open jobs and apply...'**
  String get promoJobsDescription;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEditProfile;

  /// Year the user joined the platform.
  ///
  /// In en, this message translates to:
  /// **'Member since {year}'**
  String profileMemberSince(String year);

  /// No description provided for @profileOrdersStat.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get profileOrdersStat;

  /// No description provided for @profileFavoritesStat.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get profileFavoritesStat;

  /// No description provided for @profileReviewsStat.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get profileReviewsStat;

  /// No description provided for @profileAccountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileAccountSection;

  /// No description provided for @profilePersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get profilePersonalInfo;

  /// No description provided for @profileMyOrders.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get profileMyOrders;

  /// No description provided for @profileFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get profileFavorites;

  /// No description provided for @profileAddresses.
  ///
  /// In en, this message translates to:
  /// **'My addresses'**
  String get profileAddresses;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// No description provided for @profileActivitySection.
  ///
  /// In en, this message translates to:
  /// **'My activity'**
  String get profileActivitySection;

  /// No description provided for @profileMyProfessionalFiles.
  ///
  /// In en, this message translates to:
  /// **'My professional files'**
  String get profileMyProfessionalFiles;

  /// No description provided for @profileMyListings.
  ///
  /// In en, this message translates to:
  /// **'My listings'**
  String get profileMyListings;

  /// No description provided for @profileMyReviews.
  ///
  /// In en, this message translates to:
  /// **'My reviews'**
  String get profileMyReviews;

  /// No description provided for @profileSupportSection.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get profileSupportSection;

  /// No description provided for @profileHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help center'**
  String get profileHelpCenter;

  /// No description provided for @profileContactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get profileContactUs;

  /// No description provided for @profileFaq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get profileFaq;

  /// No description provided for @profilePrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get profilePrivacyPolicy;

  /// No description provided for @profileTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get profileTerms;

  /// No description provided for @profileEmergencyTitle.
  ///
  /// In en, this message translates to:
  /// **'In case of emergency'**
  String get profileEmergencyTitle;

  /// No description provided for @profileEmergencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Important emergency numbers available around the clock'**
  String get profileEmergencySubtitle;

  /// No description provided for @profileEmergencySheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency numbers'**
  String get profileEmergencySheetTitle;

  /// No description provided for @profileEmergencyNote.
  ///
  /// In en, this message translates to:
  /// **'Direct calling will be available soon.'**
  String get profileEmergencyNote;

  /// No description provided for @profileEmergencyAmbulance.
  ///
  /// In en, this message translates to:
  /// **'Ambulance'**
  String get profileEmergencyAmbulance;

  /// No description provided for @profileEmergencyPolice.
  ///
  /// In en, this message translates to:
  /// **'Police'**
  String get profileEmergencyPolice;

  /// No description provided for @profileEmergencyFire.
  ///
  /// In en, this message translates to:
  /// **'Fire department'**
  String get profileEmergencyFire;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogout;

  /// No description provided for @profileLogoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogoutConfirmTitle;

  /// No description provided for @profileLogoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get profileLogoutConfirmMessage;

  /// No description provided for @profileLogoutUnavailable.
  ///
  /// In en, this message translates to:
  /// **'There is no active session to log out of.'**
  String get profileLogoutUnavailable;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @profileErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not load your profile. Please try again.'**
  String get profileErrorMessage;

  /// No description provided for @offersTitle.
  ///
  /// In en, this message translates to:
  /// **'Dikirnis Offers 🎁'**
  String get offersTitle;

  /// No description provided for @offersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The best products and offers from Dikirnis stores'**
  String get offersSubtitle;

  /// No description provided for @offersSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search offers...'**
  String get offersSearchHint;

  /// No description provided for @offersAllCategory.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get offersAllCategory;

  /// No description provided for @offersSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'All offers'**
  String get offersSectionTitle;

  /// No description provided for @offersEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'There are no offers available right now.'**
  String get offersEmptyMessage;

  /// No description provided for @offersNoSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No offers match your search.'**
  String get offersNoSearchResults;

  /// No description provided for @offersErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not load the offers. Please try again.'**
  String get offersErrorMessage;

  /// No description provided for @marketplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Dikirnis Marketplace'**
  String get marketplaceTitle;

  /// No description provided for @marketplaceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The best products and offers from Dikirnis stores'**
  String get marketplaceSubtitle;

  /// No description provided for @marketplaceSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products or offers...'**
  String get marketplaceSearchHint;

  /// No description provided for @marketplaceSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Products & offers'**
  String get marketplaceSectionTitle;

  /// No description provided for @marketplaceEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'There are no products available right now.'**
  String get marketplaceEmptyMessage;

  /// No description provided for @marketplaceNoSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No products match your search.'**
  String get marketplaceNoSearchResults;

  /// No description provided for @marketplaceErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not load the products. Please try again.'**
  String get marketplaceErrorMessage;

  /// No description provided for @offersFeaturedBadge.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get offersFeaturedBadge;

  /// Discount percentage shown on offer cards.
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String offersDiscountValue(int percent);

  /// Offer expiry date shown on offer cards.
  ///
  /// In en, this message translates to:
  /// **'Ends {date}'**
  String offersExpiresOn(String date);

  /// No description provided for @offersAddFavorite.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get offersAddFavorite;

  /// No description provided for @offersRemoveFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get offersRemoveFavorite;

  /// No description provided for @offersFavoriteError.
  ///
  /// In en, this message translates to:
  /// **'We could not update favorites. Please try again.'**
  String get offersFavoriteError;

  /// No description provided for @offersSortTooltip.
  ///
  /// In en, this message translates to:
  /// **'Sort results'**
  String get offersSortTooltip;

  /// No description provided for @offersSortTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort results'**
  String get offersSortTitle;

  /// No description provided for @offersSortRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get offersSortRecommended;

  /// No description provided for @offersSortPriceLow.
  ///
  /// In en, this message translates to:
  /// **'Lowest price'**
  String get offersSortPriceLow;

  /// No description provided for @offersSortPriceHigh.
  ///
  /// In en, this message translates to:
  /// **'Highest price'**
  String get offersSortPriceHigh;

  /// No description provided for @offersSortHighestDiscount.
  ///
  /// In en, this message translates to:
  /// **'Biggest discount'**
  String get offersSortHighestDiscount;

  /// No description provided for @offersSortMostViewed.
  ///
  /// In en, this message translates to:
  /// **'Most viewed'**
  String get offersSortMostViewed;

  /// No description provided for @offersSellProduct.
  ///
  /// In en, this message translates to:
  /// **'Sell a product'**
  String get offersSellProduct;

  /// No description provided for @offersSellUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Selling products will be available after the publishing service is connected.'**
  String get offersSellUnavailable;

  /// No description provided for @offerDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Offer details'**
  String get offerDetailsTitle;

  /// No description provided for @offerDetailsDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'About the offer'**
  String get offerDetailsDescriptionTitle;

  /// No description provided for @offerDetailsNotFound.
  ///
  /// In en, this message translates to:
  /// **'This offer could not be found.'**
  String get offerDetailsNotFound;

  /// No description provided for @productDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Product details'**
  String get productDetailsTitle;

  /// No description provided for @productDetailsDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Product description'**
  String get productDetailsDescriptionTitle;

  /// No description provided for @productDetailsNotFound.
  ///
  /// In en, this message translates to:
  /// **'This product could not be found.'**
  String get productDetailsNotFound;

  /// No description provided for @offerDetailsSave.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get offerDetailsSave;

  /// No description provided for @offerDetailsSaved.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get offerDetailsSaved;

  /// No description provided for @offerDetailsDiscountLabel.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get offerDetailsDiscountLabel;

  /// No description provided for @offerDetailsExpiryLabel.
  ///
  /// In en, this message translates to:
  /// **'Ends'**
  String get offerDetailsExpiryLabel;

  /// No description provided for @offerDetailsViewsLabel.
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get offerDetailsViewsLabel;

  /// Product publish date shown in product details.
  ///
  /// In en, this message translates to:
  /// **'Published {date}'**
  String offerDetailsPublishedLabel(String date);

  /// No description provided for @offerDetailsAvailabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get offerDetailsAvailabilityLabel;

  /// No description provided for @offerDetailsAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get offerDetailsAvailable;

  /// No description provided for @offerDetailsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get offerDetailsUnavailable;

  /// No description provided for @offerDetailsOriginalPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price before discount'**
  String get offerDetailsOriginalPriceLabel;

  /// Current image position and total number of product images.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String offerGalleryCounter(int current, int total);

  /// No description provided for @offerShareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Copy product information'**
  String get offerShareTooltip;

  /// No description provided for @offerShareCopied.
  ///
  /// In en, this message translates to:
  /// **'Product information copied.'**
  String get offerShareCopied;

  /// No description provided for @offerSellerTitle.
  ///
  /// In en, this message translates to:
  /// **'Seller information'**
  String get offerSellerTitle;

  /// No description provided for @offerSellerVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified seller'**
  String get offerSellerVerified;

  /// Year the seller joined the marketplace.
  ///
  /// In en, this message translates to:
  /// **'Member since {year}'**
  String offerSellerMemberSince(String year);

  /// No description provided for @offerContactCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get offerContactCall;

  /// No description provided for @offerContactWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get offerContactWhatsapp;

  /// No description provided for @offerContactUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Contact number is unavailable.'**
  String get offerContactUnavailable;

  /// No description provided for @offerContactCopied.
  ///
  /// In en, this message translates to:
  /// **'Contact number copied.'**
  String get offerContactCopied;

  /// No description provided for @offerCommentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get offerCommentsTitle;

  /// No description provided for @offerCommentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No comments yet.'**
  String get offerCommentsEmpty;

  /// No description provided for @offerCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Add a comment...'**
  String get offerCommentHint;

  /// No description provided for @offerCommentSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get offerCommentSend;

  /// No description provided for @offerCommentEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Write a comment first.'**
  String get offerCommentEmptyError;

  /// No description provided for @offerCommentUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Adding comments is unavailable until the comments service is connected.'**
  String get offerCommentUnavailable;

  /// No description provided for @offerAiTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart guidance'**
  String get offerAiTitle;

  /// No description provided for @offerAiPreviewNote.
  ///
  /// In en, this message translates to:
  /// **'Local preview — the recommendation service is not connected yet.'**
  String get offerAiPreviewNote;

  /// No description provided for @offerAiStrongDiscount.
  ///
  /// In en, this message translates to:
  /// **'This offer has a strong discount. Review the expiry date and seller details before ordering.'**
  String get offerAiStrongDiscount;

  /// No description provided for @offerAiCompare.
  ///
  /// In en, this message translates to:
  /// **'Compare this offer with similar products and confirm your needs before ordering.'**
  String get offerAiCompare;

  /// No description provided for @offerSimilarTitle.
  ///
  /// In en, this message translates to:
  /// **'Similar products'**
  String get offerSimilarTitle;

  /// No description provided for @offerOrderNow.
  ///
  /// In en, this message translates to:
  /// **'Order now'**
  String get offerOrderNow;

  /// No description provided for @offerOrderUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Ordering unavailable'**
  String get offerOrderUnavailableTitle;

  /// No description provided for @offerOrderUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'The ordering service is not connected yet, and no order was submitted.'**
  String get offerOrderUnavailableMessage;

  /// No description provided for @currencyEgp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get currencyEgp;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
