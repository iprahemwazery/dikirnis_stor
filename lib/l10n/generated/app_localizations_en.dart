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
  String get settingsTitle => 'Settings';

  @override
  String get settingsAppearanceSection => 'Appearance';

  @override
  String get settingsLanguageSection => 'Language';

  @override
  String get settingsThemeSystem => 'Follow system';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsLanguageSystem => 'Follow system';

  @override
  String get settingsLanguageArabic => 'Arabic';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsSaveError =>
      'We could not save your settings. Please try again.';

  @override
  String get settingsOfflineNote => 'Settings are stored on this device.';

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
  String get businessesTitle => 'Businesses';

  @override
  String get pressBackAgainToExit => 'Press back again to exit the app';

  @override
  String get businessesAllLabel => 'All';

  @override
  String get businessesSearchHint => 'Search for a business or place...';

  @override
  String get businessesNoSearchResults => 'No businesses match your search.';

  @override
  String get businessesCountLabel => 'businesses';

  @override
  String get businessesAddCta => 'Add business';

  @override
  String get businessesAddTitle => 'Add a new business';

  @override
  String get businessesFormName => 'Business name';

  @override
  String get businessesFormLocation => 'Address';

  @override
  String get businessesFormDescription => 'Short description';

  @override
  String get businessesFormPhone => 'Contact number (optional)';

  @override
  String get businessesFormCategory => 'Category';

  @override
  String get businessesFormRequired => 'This field is required.';

  @override
  String get businessesFormIntro =>
      'Enter the business details. They will not be saved until the publishing service is connected.';

  @override
  String get businessesFormSubmit => 'Submit business';

  @override
  String get businessesCreateUnavailableTitle =>
      'Publishing is not available yet';

  @override
  String get businessesCreateUnavailableMessage =>
      'Your details were validated, but saving businesses will be available after the backend is connected.';

  @override
  String get businessesFormDiscardTitle => 'Discard changes?';

  @override
  String get businessesFormDiscardMessage =>
      'The business details you entered will be lost.';

  @override
  String get businessesFormDiscardConfirm => 'Exit';

  @override
  String get businessesFormContinue => 'Keep editing';

  @override
  String get businessDetailsTitle => 'Business details';

  @override
  String get businessAboutTitle => 'About';

  @override
  String get businessLocationTitle => 'Location';

  @override
  String get businessContactTitle => 'Contact';

  @override
  String get businessRatingLabel => 'Rating';

  @override
  String get businessesEmpty => 'There are no businesses in this section yet.';

  @override
  String get businessesErrorMessage =>
      'Could not load businesses. Please try again.';

  @override
  String get businessesNotFound => 'This business could not be found.';

  @override
  String get businessContactUnavailable =>
      'No contact details are available for this business.';

  @override
  String get businessMapUnavailable =>
      'The location is shown as text; the map will be available once the maps service is connected.';

  @override
  String get jobsTitle => 'Jobs';

  @override
  String get jobsVacanciesTab => 'Jobs';

  @override
  String get jobsCandidatesTab => 'Available for work';

  @override
  String get jobsSearchVacanciesHint => 'Search jobs or companies...';

  @override
  String get jobsSearchCandidatesHint => 'Search by name or skill...';

  @override
  String get jobsAllCategories => 'All';

  @override
  String get jobsFilters => 'Filters';

  @override
  String get jobsClearFilters => 'Clear filters';

  @override
  String jobsResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results',
      one: '1 result',
      zero: 'No results',
    );
    return '$_temp0';
  }

  @override
  String get jobsVacanciesEmpty => 'No jobs are available right now.';

  @override
  String get jobsCandidatesEmpty => 'No candidates are available right now.';

  @override
  String get jobsNoSearchResults => 'No results match your search or filters.';

  @override
  String get jobsErrorMessage => 'We could not load jobs. Please try again.';

  @override
  String get jobsFilterCategory => 'Category';

  @override
  String get jobsFilterEmploymentType => 'Employment type';

  @override
  String get jobsFilterAvailability => 'Availability';

  @override
  String get jobsFilterSort => 'Sort';

  @override
  String get jobsSortNewest => 'Newest';

  @override
  String get jobsSortSalaryHigh => 'Highest salary';

  @override
  String get jobsSortSalaryLow => 'Lowest salary';

  @override
  String get jobsSortExperienceHigh => 'Most experienced';

  @override
  String get jobsEmploymentFullTime => 'Full time';

  @override
  String get jobsEmploymentPartTime => 'Part time';

  @override
  String get jobsEmploymentContract => 'Contract';

  @override
  String get jobsEmploymentInternship => 'Internship';

  @override
  String get jobsEmploymentFreelance => 'Freelance';

  @override
  String get jobsAvailabilityNow => 'Available now';

  @override
  String get jobsAvailabilityOpen => 'Open to offers';

  @override
  String get jobsApplyTitle => 'Apply for this job';

  @override
  String get jobsApplyInstructions => 'How to apply';

  @override
  String get jobsContactTitle => 'Contact';

  @override
  String get jobsContactCall => 'Call';

  @override
  String get jobsContactWhatsapp => 'WhatsApp';

  @override
  String get jobsContactEmail => 'Email';

  @override
  String get jobsContactUnavailable => 'No contact information is available.';

  @override
  String get jobsContactCopied => 'Contact information copied.';

  @override
  String get jobsContactCopyNote =>
      'Contact details are copied; direct calling is unavailable until the calling service is connected.';

  @override
  String get jobsCompanyTitle => 'About the company';

  @override
  String get jobsDescriptionTitle => 'Job description';

  @override
  String get jobsResponsibilitiesTitle => 'Responsibilities';

  @override
  String get jobsRequirementsTitle => 'Requirements';

  @override
  String get jobsExperienceLabel => 'Experience required';

  @override
  String jobsExperienceYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years years',
      one: '1 year',
      zero: 'Less than a year',
    );
    return '$_temp0';
  }

  @override
  String get jobsSalaryLabel => 'Salary';

  @override
  String get jobsSalaryNotDisclosed => 'Salary not disclosed';

  @override
  String jobsSalaryRange(String min, String max, String currency) {
    return '$min - $max $currency';
  }

  @override
  String jobsSalaryFrom(String min, String currency) {
    return 'From $min $currency';
  }

  @override
  String get jobsSalaryPerMonth => 'per month';

  @override
  String get jobsSalaryPerDay => 'per day';

  @override
  String get jobsSalaryPerHour => 'per hour';

  @override
  String get jobsSalaryPerYear => 'per year';

  @override
  String get jobsPublishedLabel => 'Published';

  @override
  String get jobsPublishedToday => 'Posted today';

  @override
  String get jobsPublishedYesterday => 'Posted yesterday';

  @override
  String jobsPublishedDaysAgo(int count) {
    return 'Posted $count days ago';
  }

  @override
  String get jobsLocationLabel => 'Location';

  @override
  String get jobsCategoryLabel => 'Category';

  @override
  String get jobsVerifiedEmployer => 'Verified employer';

  @override
  String get jobsFeaturedBadge => 'Featured';

  @override
  String get jobsEmploymentTypeLabel => 'Employment type';

  @override
  String get jobsViewDetails => 'View details';

  @override
  String get jobsAddListing => 'Add listing';

  @override
  String get jobsCreateVacancyTitle => 'Post a job';

  @override
  String get jobsCreateCandidateTitle => 'Create availability profile';

  @override
  String get jobsCreateVacancySubtitle =>
      'Fill in the job details. Nothing is sent until the publishing service is connected.';

  @override
  String get jobsCreateCandidateSubtitle =>
      'Fill in your professional details. Nothing is sent until the publishing service is connected.';

  @override
  String get jobsCreateUnavailableTitle => 'Publishing unavailable';

  @override
  String get jobsCreateUnavailableMessage =>
      'The job publishing service is not connected yet, and no data was submitted.';

  @override
  String get jobsFormRequired => 'This field is required.';

  @override
  String get jobsFormTitleLabel => 'Job title';

  @override
  String get jobsFormCompanyLabel => 'Company name';

  @override
  String get jobsFormDescriptionLabel => 'Job description';

  @override
  String get jobsFormResponsibilitiesLabel => 'Responsibilities (one per line)';

  @override
  String get jobsFormRequirementsLabel => 'Requirements (one per line)';

  @override
  String get jobsFormCategoryLabel => 'Category';

  @override
  String get jobsFormEmploymentTypeLabel => 'Employment type';

  @override
  String get jobsFormSalaryMinLabel => 'Minimum salary';

  @override
  String get jobsFormSalaryMaxLabel => 'Maximum salary';

  @override
  String get jobsFormLocationLabel => 'Location';

  @override
  String get jobsFormPhoneLabel => 'Contact phone';

  @override
  String get jobsFormEmailLabel => 'Email';

  @override
  String get jobsFormApplicationLabel => 'Application instructions';

  @override
  String get jobsFormSubmit => 'Submit listing';

  @override
  String get jobsFormNameLabel => 'Full name';

  @override
  String get jobsFormProfessionalTitleLabel => 'Professional title';

  @override
  String get jobsFormSkillsLabel => 'Skills (comma separated)';

  @override
  String get jobsFormExperienceYearsLabel => 'Years of experience';

  @override
  String get jobsFormPreferredLocationLabel => 'Preferred location';

  @override
  String get jobsFormDesiredTypeLabel => 'Desired employment type';

  @override
  String get jobsFormSummaryLabel => 'Professional summary';

  @override
  String get jobsFormEducationLabel => 'Education';

  @override
  String get jobsFormCvLabel => 'CV';

  @override
  String get jobsFormNumberInvalid => 'Enter a valid number.';

  @override
  String get jobsFormEmailInvalid => 'Enter a valid email address.';

  @override
  String get jobsFormCvUnavailable =>
      'CV upload will be available after the files service is connected.';

  @override
  String get jobsFormDiscardTitle => 'Discard changes?';

  @override
  String get jobsFormDiscardMessage =>
      'You have unsaved data. Do you want to leave?';

  @override
  String get jobsFormDiscardConfirm => 'Leave';

  @override
  String get jobsFormContinue => 'Keep editing';

  @override
  String get jobsCandidateSkillsTitle => 'Skills';

  @override
  String get jobsCandidateExperienceTitle => 'Work experience';

  @override
  String get jobsCandidateEducationTitle => 'Education';

  @override
  String get jobsCandidateCertificatesTitle => 'Certificates';

  @override
  String get jobsCandidateSummaryTitle => 'Professional summary';

  @override
  String get jobsCandidateAvailabilityLabel => 'Availability';

  @override
  String get jobsCandidateDesiredTypeLabel => 'Desired employment';

  @override
  String get jobsCandidatePreferredLocationLabel => 'Preferred location';

  @override
  String get jobsCandidateCvTitle => 'CV';

  @override
  String get jobsCandidateCvUnavailable =>
      'No CV was attached; the available professional information is shown instead.';

  @override
  String get jobsDetailsTitle => 'Job details';

  @override
  String get jobsCandidateDetailsTitle => 'Candidate profile';

  @override
  String get jobsDetailsNotFound => 'This item could not be found.';

  @override
  String get jobsFilterSheetTitle => 'Filter results';

  @override
  String get jobsApplyFilter => 'Apply';

  @override
  String get jobsReset => 'Reset';

  @override
  String jobsFromTo(String from, String to) {
    return '$from - $to';
  }

  @override
  String get jobsPresent => 'Present';

  @override
  String get ok => 'OK';
}
