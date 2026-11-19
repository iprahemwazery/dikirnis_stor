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

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAppearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearanceSection;

  /// No description provided for @settingsLanguageSection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageSection;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get settingsLanguageArabic;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsSaveError.
  ///
  /// In en, this message translates to:
  /// **'We could not save your settings. Please try again.'**
  String get settingsSaveError;

  /// No description provided for @settingsOfflineNote.
  ///
  /// In en, this message translates to:
  /// **'Settings are stored on this device.'**
  String get settingsOfflineNote;

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

  /// No description provided for @businessesTitle.
  ///
  /// In en, this message translates to:
  /// **'Businesses'**
  String get businessesTitle;

  /// No description provided for @pressBackAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit the app'**
  String get pressBackAgainToExit;

  /// No description provided for @businessesAllLabel.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get businessesAllLabel;

  /// No description provided for @businessesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a business or place...'**
  String get businessesSearchHint;

  /// No description provided for @businessesNoSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No businesses match your search.'**
  String get businessesNoSearchResults;

  /// No description provided for @businessesCountLabel.
  ///
  /// In en, this message translates to:
  /// **'businesses'**
  String get businessesCountLabel;

  /// No description provided for @businessesAddCta.
  ///
  /// In en, this message translates to:
  /// **'Add business'**
  String get businessesAddCta;

  /// No description provided for @businessesAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a new business'**
  String get businessesAddTitle;

  /// No description provided for @businessesFormName.
  ///
  /// In en, this message translates to:
  /// **'Business name'**
  String get businessesFormName;

  /// No description provided for @businessesFormLocation.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get businessesFormLocation;

  /// No description provided for @businessesFormDescription.
  ///
  /// In en, this message translates to:
  /// **'Short description'**
  String get businessesFormDescription;

  /// No description provided for @businessesFormPhone.
  ///
  /// In en, this message translates to:
  /// **'Contact number (optional)'**
  String get businessesFormPhone;

  /// No description provided for @businessesFormCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get businessesFormCategory;

  /// No description provided for @businessesFormRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get businessesFormRequired;

  /// No description provided for @businessesFormIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter the business details. They will not be saved until the publishing service is connected.'**
  String get businessesFormIntro;

  /// No description provided for @businessesFormSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit business'**
  String get businessesFormSubmit;

  /// No description provided for @businessesCreateUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Publishing is not available yet'**
  String get businessesCreateUnavailableTitle;

  /// No description provided for @businessesCreateUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Your details were validated, but saving businesses will be available after the backend is connected.'**
  String get businessesCreateUnavailableMessage;

  /// No description provided for @businessesFormDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get businessesFormDiscardTitle;

  /// No description provided for @businessesFormDiscardMessage.
  ///
  /// In en, this message translates to:
  /// **'The business details you entered will be lost.'**
  String get businessesFormDiscardMessage;

  /// No description provided for @businessesFormDiscardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get businessesFormDiscardConfirm;

  /// No description provided for @businessesFormContinue.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get businessesFormContinue;

  /// No description provided for @businessDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Business details'**
  String get businessDetailsTitle;

  /// No description provided for @businessAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get businessAboutTitle;

  /// No description provided for @businessLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get businessLocationTitle;

  /// No description provided for @businessContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get businessContactTitle;

  /// No description provided for @businessRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get businessRatingLabel;

  /// No description provided for @businessesEmpty.
  ///
  /// In en, this message translates to:
  /// **'There are no businesses in this section yet.'**
  String get businessesEmpty;

  /// No description provided for @businessesErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not load businesses. Please try again.'**
  String get businessesErrorMessage;

  /// No description provided for @businessesNotFound.
  ///
  /// In en, this message translates to:
  /// **'This business could not be found.'**
  String get businessesNotFound;

  /// No description provided for @businessContactUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No contact details are available for this business.'**
  String get businessContactUnavailable;

  /// No description provided for @businessMapUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The location is shown as text; the map will be available once the maps service is connected.'**
  String get businessMapUnavailable;

  /// No description provided for @jobsTitle.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobsTitle;

  /// No description provided for @jobsVacanciesTab.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobsVacanciesTab;

  /// No description provided for @jobsCandidatesTab.
  ///
  /// In en, this message translates to:
  /// **'Available for work'**
  String get jobsCandidatesTab;

  /// No description provided for @jobsSearchVacanciesHint.
  ///
  /// In en, this message translates to:
  /// **'Search jobs or companies...'**
  String get jobsSearchVacanciesHint;

  /// No description provided for @jobsSearchCandidatesHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or skill...'**
  String get jobsSearchCandidatesHint;

  /// No description provided for @jobsAllCategories.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get jobsAllCategories;

  /// No description provided for @jobsFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get jobsFilters;

  /// No description provided for @jobsClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get jobsClearFilters;

  /// Number of job or candidate results.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No results} =1{1 result} other{{count} results}}'**
  String jobsResultsCount(int count);

  /// No description provided for @jobsVacanciesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No jobs are available right now.'**
  String get jobsVacanciesEmpty;

  /// No description provided for @jobsCandidatesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No candidates are available right now.'**
  String get jobsCandidatesEmpty;

  /// No description provided for @jobsNoSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No results match your search or filters.'**
  String get jobsNoSearchResults;

  /// No description provided for @jobsErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not load jobs. Please try again.'**
  String get jobsErrorMessage;

  /// No description provided for @jobsFilterCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get jobsFilterCategory;

  /// No description provided for @jobsFilterEmploymentType.
  ///
  /// In en, this message translates to:
  /// **'Employment type'**
  String get jobsFilterEmploymentType;

  /// No description provided for @jobsFilterAvailability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get jobsFilterAvailability;

  /// No description provided for @jobsFilterSort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get jobsFilterSort;

  /// No description provided for @jobsSortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get jobsSortNewest;

  /// No description provided for @jobsSortSalaryHigh.
  ///
  /// In en, this message translates to:
  /// **'Highest salary'**
  String get jobsSortSalaryHigh;

  /// No description provided for @jobsSortSalaryLow.
  ///
  /// In en, this message translates to:
  /// **'Lowest salary'**
  String get jobsSortSalaryLow;

  /// No description provided for @jobsSortExperienceHigh.
  ///
  /// In en, this message translates to:
  /// **'Most experienced'**
  String get jobsSortExperienceHigh;

  /// No description provided for @jobsEmploymentFullTime.
  ///
  /// In en, this message translates to:
  /// **'Full time'**
  String get jobsEmploymentFullTime;

  /// No description provided for @jobsEmploymentPartTime.
  ///
  /// In en, this message translates to:
  /// **'Part time'**
  String get jobsEmploymentPartTime;

  /// No description provided for @jobsEmploymentContract.
  ///
  /// In en, this message translates to:
  /// **'Contract'**
  String get jobsEmploymentContract;

  /// No description provided for @jobsEmploymentInternship.
  ///
  /// In en, this message translates to:
  /// **'Internship'**
  String get jobsEmploymentInternship;

  /// No description provided for @jobsEmploymentFreelance.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get jobsEmploymentFreelance;

  /// No description provided for @jobsAvailabilityNow.
  ///
  /// In en, this message translates to:
  /// **'Available now'**
  String get jobsAvailabilityNow;

  /// No description provided for @jobsAvailabilityOpen.
  ///
  /// In en, this message translates to:
  /// **'Open to offers'**
  String get jobsAvailabilityOpen;

  /// No description provided for @jobsApplyTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply for this job'**
  String get jobsApplyTitle;

  /// No description provided for @jobsApplyInstructions.
  ///
  /// In en, this message translates to:
  /// **'How to apply'**
  String get jobsApplyInstructions;

  /// No description provided for @jobsContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get jobsContactTitle;

  /// No description provided for @jobsContactCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get jobsContactCall;

  /// No description provided for @jobsContactWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get jobsContactWhatsapp;

  /// No description provided for @jobsContactEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get jobsContactEmail;

  /// No description provided for @jobsContactUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No contact information is available.'**
  String get jobsContactUnavailable;

  /// No description provided for @jobsContactCopied.
  ///
  /// In en, this message translates to:
  /// **'Contact information copied.'**
  String get jobsContactCopied;

  /// No description provided for @jobsContactCopyNote.
  ///
  /// In en, this message translates to:
  /// **'Contact details are copied; direct calling is unavailable until the calling service is connected.'**
  String get jobsContactCopyNote;

  /// No description provided for @jobsCompanyTitle.
  ///
  /// In en, this message translates to:
  /// **'About the company'**
  String get jobsCompanyTitle;

  /// No description provided for @jobsDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Job description'**
  String get jobsDescriptionTitle;

  /// No description provided for @jobsResponsibilitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Responsibilities'**
  String get jobsResponsibilitiesTitle;

  /// No description provided for @jobsRequirementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Requirements'**
  String get jobsRequirementsTitle;

  /// No description provided for @jobsExperienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Experience required'**
  String get jobsExperienceLabel;

  /// Required or possessed years of experience.
  ///
  /// In en, this message translates to:
  /// **'{years, plural, =0{Less than a year} =1{1 year} other{{years} years}}'**
  String jobsExperienceYears(int years);

  /// No description provided for @jobsSalaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get jobsSalaryLabel;

  /// No description provided for @jobsSalaryNotDisclosed.
  ///
  /// In en, this message translates to:
  /// **'Salary not disclosed'**
  String get jobsSalaryNotDisclosed;

  /// Salary range with formatted bounds and currency.
  ///
  /// In en, this message translates to:
  /// **'{min} - {max} {currency}'**
  String jobsSalaryRange(String min, String max, String currency);

  /// Minimum salary with currency.
  ///
  /// In en, this message translates to:
  /// **'From {min} {currency}'**
  String jobsSalaryFrom(String min, String currency);

  /// No description provided for @jobsSalaryPerMonth.
  ///
  /// In en, this message translates to:
  /// **'per month'**
  String get jobsSalaryPerMonth;

  /// No description provided for @jobsSalaryPerDay.
  ///
  /// In en, this message translates to:
  /// **'per day'**
  String get jobsSalaryPerDay;

  /// No description provided for @jobsSalaryPerHour.
  ///
  /// In en, this message translates to:
  /// **'per hour'**
  String get jobsSalaryPerHour;

  /// No description provided for @jobsSalaryPerYear.
  ///
  /// In en, this message translates to:
  /// **'per year'**
  String get jobsSalaryPerYear;

  /// No description provided for @jobsPublishedLabel.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get jobsPublishedLabel;

  /// No description provided for @jobsPublishedToday.
  ///
  /// In en, this message translates to:
  /// **'Posted today'**
  String get jobsPublishedToday;

  /// No description provided for @jobsPublishedYesterday.
  ///
  /// In en, this message translates to:
  /// **'Posted yesterday'**
  String get jobsPublishedYesterday;

  /// Relative publication date in days.
  ///
  /// In en, this message translates to:
  /// **'Posted {count} days ago'**
  String jobsPublishedDaysAgo(int count);

  /// No description provided for @jobsLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get jobsLocationLabel;

  /// No description provided for @jobsCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get jobsCategoryLabel;

  /// No description provided for @jobsVerifiedEmployer.
  ///
  /// In en, this message translates to:
  /// **'Verified employer'**
  String get jobsVerifiedEmployer;

  /// No description provided for @jobsFeaturedBadge.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get jobsFeaturedBadge;

  /// No description provided for @jobsEmploymentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Employment type'**
  String get jobsEmploymentTypeLabel;

  /// No description provided for @jobsViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get jobsViewDetails;

  /// No description provided for @jobsAddListing.
  ///
  /// In en, this message translates to:
  /// **'Add listing'**
  String get jobsAddListing;

  /// No description provided for @jobsCreateVacancyTitle.
  ///
  /// In en, this message translates to:
  /// **'Post a job'**
  String get jobsCreateVacancyTitle;

  /// No description provided for @jobsCreateCandidateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create availability profile'**
  String get jobsCreateCandidateTitle;

  /// No description provided for @jobsCreateVacancySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in the job details. Nothing is sent until the publishing service is connected.'**
  String get jobsCreateVacancySubtitle;

  /// No description provided for @jobsCreateCandidateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in your professional details. Nothing is sent until the publishing service is connected.'**
  String get jobsCreateCandidateSubtitle;

  /// No description provided for @jobsCreateUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Publishing unavailable'**
  String get jobsCreateUnavailableTitle;

  /// No description provided for @jobsCreateUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'The job publishing service is not connected yet, and no data was submitted.'**
  String get jobsCreateUnavailableMessage;

  /// No description provided for @jobsFormRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get jobsFormRequired;

  /// No description provided for @jobsFormTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Job title'**
  String get jobsFormTitleLabel;

  /// No description provided for @jobsFormCompanyLabel.
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get jobsFormCompanyLabel;

  /// No description provided for @jobsFormDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Job description'**
  String get jobsFormDescriptionLabel;

  /// No description provided for @jobsFormResponsibilitiesLabel.
  ///
  /// In en, this message translates to:
  /// **'Responsibilities (one per line)'**
  String get jobsFormResponsibilitiesLabel;

  /// No description provided for @jobsFormRequirementsLabel.
  ///
  /// In en, this message translates to:
  /// **'Requirements (one per line)'**
  String get jobsFormRequirementsLabel;

  /// No description provided for @jobsFormCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get jobsFormCategoryLabel;

  /// No description provided for @jobsFormEmploymentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Employment type'**
  String get jobsFormEmploymentTypeLabel;

  /// No description provided for @jobsFormSalaryMinLabel.
  ///
  /// In en, this message translates to:
  /// **'Minimum salary'**
  String get jobsFormSalaryMinLabel;

  /// No description provided for @jobsFormSalaryMaxLabel.
  ///
  /// In en, this message translates to:
  /// **'Maximum salary'**
  String get jobsFormSalaryMaxLabel;

  /// No description provided for @jobsFormLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get jobsFormLocationLabel;

  /// No description provided for @jobsFormPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact phone'**
  String get jobsFormPhoneLabel;

  /// No description provided for @jobsFormEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get jobsFormEmailLabel;

  /// No description provided for @jobsFormApplicationLabel.
  ///
  /// In en, this message translates to:
  /// **'Application instructions'**
  String get jobsFormApplicationLabel;

  /// No description provided for @jobsFormSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit listing'**
  String get jobsFormSubmit;

  /// No description provided for @jobsFormNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get jobsFormNameLabel;

  /// No description provided for @jobsFormProfessionalTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Professional title'**
  String get jobsFormProfessionalTitleLabel;

  /// No description provided for @jobsFormSkillsLabel.
  ///
  /// In en, this message translates to:
  /// **'Skills (comma separated)'**
  String get jobsFormSkillsLabel;

  /// No description provided for @jobsFormExperienceYearsLabel.
  ///
  /// In en, this message translates to:
  /// **'Years of experience'**
  String get jobsFormExperienceYearsLabel;

  /// No description provided for @jobsFormPreferredLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Preferred location'**
  String get jobsFormPreferredLocationLabel;

  /// No description provided for @jobsFormDesiredTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Desired employment type'**
  String get jobsFormDesiredTypeLabel;

  /// No description provided for @jobsFormSummaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Professional summary'**
  String get jobsFormSummaryLabel;

  /// No description provided for @jobsFormEducationLabel.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get jobsFormEducationLabel;

  /// No description provided for @jobsFormCvLabel.
  ///
  /// In en, this message translates to:
  /// **'CV'**
  String get jobsFormCvLabel;

  /// No description provided for @jobsFormNumberInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number.'**
  String get jobsFormNumberInvalid;

  /// No description provided for @jobsFormEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get jobsFormEmailInvalid;

  /// No description provided for @jobsFormCvUnavailable.
  ///
  /// In en, this message translates to:
  /// **'CV upload will be available after the files service is connected.'**
  String get jobsFormCvUnavailable;

  /// No description provided for @jobsFormDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get jobsFormDiscardTitle;

  /// No description provided for @jobsFormDiscardMessage.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved data. Do you want to leave?'**
  String get jobsFormDiscardMessage;

  /// No description provided for @jobsFormDiscardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get jobsFormDiscardConfirm;

  /// No description provided for @jobsFormContinue.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get jobsFormContinue;

  /// No description provided for @jobsCandidateSkillsTitle.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get jobsCandidateSkillsTitle;

  /// No description provided for @jobsCandidateExperienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Work experience'**
  String get jobsCandidateExperienceTitle;

  /// No description provided for @jobsCandidateEducationTitle.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get jobsCandidateEducationTitle;

  /// No description provided for @jobsCandidateCertificatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get jobsCandidateCertificatesTitle;

  /// No description provided for @jobsCandidateSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Professional summary'**
  String get jobsCandidateSummaryTitle;

  /// No description provided for @jobsCandidateAvailabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get jobsCandidateAvailabilityLabel;

  /// No description provided for @jobsCandidateDesiredTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Desired employment'**
  String get jobsCandidateDesiredTypeLabel;

  /// No description provided for @jobsCandidatePreferredLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Preferred location'**
  String get jobsCandidatePreferredLocationLabel;

  /// No description provided for @jobsCandidateCvTitle.
  ///
  /// In en, this message translates to:
  /// **'CV'**
  String get jobsCandidateCvTitle;

  /// No description provided for @jobsCandidateCvUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No CV was attached; the available professional information is shown instead.'**
  String get jobsCandidateCvUnavailable;

  /// No description provided for @jobsDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Job details'**
  String get jobsDetailsTitle;

  /// No description provided for @jobsCandidateDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Candidate profile'**
  String get jobsCandidateDetailsTitle;

  /// No description provided for @jobsDetailsNotFound.
  ///
  /// In en, this message translates to:
  /// **'This item could not be found.'**
  String get jobsDetailsNotFound;

  /// No description provided for @jobsFilterSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter results'**
  String get jobsFilterSheetTitle;

  /// No description provided for @jobsApplyFilter.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get jobsApplyFilter;

  /// No description provided for @jobsReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get jobsReset;

  /// A date or year range.
  ///
  /// In en, this message translates to:
  /// **'{from} - {to}'**
  String jobsFromTo(String from, String to);

  /// No description provided for @jobsPresent.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get jobsPresent;

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
