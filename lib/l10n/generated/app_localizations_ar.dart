// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'دكرنس ستور';

  @override
  String get homeHeadline => 'خدماتك المحلية، قريبة منك';

  @override
  String get homeSubtitle => 'اكتشف الخدمات والمحلات الموثوقة في دكرنس.';

  @override
  String get locationLabel => 'دكرنس، الدقهلية';

  @override
  String get searchHint => 'ابحث عن خدمة';

  @override
  String get categoriesTitle => 'تصفح الأقسام';

  @override
  String providersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مقدم خدمة',
      many: '$count مقدم خدمة',
      few: '$count مقدمي خدمة',
      two: 'مقدما خدمة',
      one: 'مقدم خدمة واحد',
      zero: 'لا يوجد مقدمو خدمة',
    );
    return '$_temp0';
  }

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get categoriesErrorMessage => 'تعذر تحميل الأقسام. حاول مرة أخرى.';

  @override
  String get emptyCategoriesMessage => 'لا توجد أقسام متاحة حالياً.';

  @override
  String get noSearchResults => 'لا توجد خدمات تطابق بحثك.';

  @override
  String get pageNotFoundTitle => 'الصفحة غير موجودة';

  @override
  String get pageNotFoundMessage =>
      'الصفحة التي تبحث عنها غير موجودة أو تم نقلها.';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get goodEvening => 'مساء الخير';

  @override
  String get homeSearchHint => 'ابحث عن مطعم، دكتور، محل...';

  @override
  String get notificationsLabel => 'الإشعارات';

  @override
  String get messagesLabel => 'الرسائل';

  @override
  String get homeCategoriesTitle => 'الأقسام';

  @override
  String get mostViewedTitle => 'الأكثر مشاهدة هذا الأسبوع';

  @override
  String get recentlyAddedTitle => 'انضم حديثاً';

  @override
  String get medicalSectorTitle => 'القطاع الطبي';

  @override
  String get restaurantsCafesTitle => 'المطاعم والكافيهات';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get moreLabel => 'المزيد';

  @override
  String get newBadge => 'جديد';

  @override
  String get verifiedBadge => 'موثّق';

  @override
  String get sponsoredBadge => 'مدعوم';

  @override
  String get viewsLabel => 'مشاهدة';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navExplore => 'الاستكشافات';

  @override
  String get navMarketplace => 'السوق';

  @override
  String get navOffers => 'العروض';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get comingSoonMessage => 'هذه الميزة ستكون متاحة قريباً.';

  @override
  String get searchComingSoonMessage => 'البحث الشامل في الدليل سيتوفر قريباً.';

  @override
  String get homeErrorMessage => 'تعذر تحميل الصفحة الرئيسية. حاول مرة أخرى.';

  @override
  String get homeEmptyMessage => 'لا توجد بيانات لعرضها حالياً.';

  @override
  String get advertisementCloseLabel => 'إغلاق الإعلان';

  @override
  String get advertisementActionLabel => 'فتح الإعلان';

  @override
  String get exploreTitle => 'الفئات';

  @override
  String get allCategoriesTitle => 'جميع الأقسام';

  @override
  String subcategoriesCount(int count) {
    return '$count قسم فرعي';
  }

  @override
  String get promoOffersTitle => 'العروض';

  @override
  String get promoOffersDescription => 'اكتشف أفضل العروض والخصومات...';

  @override
  String get promoNewsTitle => 'الأخبار';

  @override
  String get promoNewsDescription => 'تابع آخر الأخبار المحلية والعالمية';

  @override
  String get promoMarketTitle => 'أسعار السوق';

  @override
  String get promoMarketDescription => 'أسعار الخضروات واللحوم والسلع';

  @override
  String get promoJobsTitle => 'التوظيف';

  @override
  String get promoJobsDescription => 'استعرض الوظائف الشاغرة وقدّم عليها...';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileEditProfile => 'تعديل الملف';

  @override
  String profileMemberSince(String year) {
    return 'عضو منذ $year';
  }

  @override
  String get profileOrdersStat => 'الطلبات';

  @override
  String get profileFavoritesStat => 'المفضلة';

  @override
  String get profileReviewsStat => 'التقييمات';

  @override
  String get profileAccountSection => 'الحساب';

  @override
  String get profilePersonalInfo => 'بياناتي الشخصية';

  @override
  String get profileMyOrders => 'طلباتي';

  @override
  String get profileFavorites => 'المفضلة';

  @override
  String get profileAddresses => 'عناويني';

  @override
  String get profileSettings => 'الإعدادات';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsAppearanceSection => 'المظهر';

  @override
  String get settingsLanguageSection => 'اللغة';

  @override
  String get settingsThemeSystem => 'حسب إعدادات النظام';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsLanguageSystem => 'حسب إعدادات النظام';

  @override
  String get settingsLanguageArabic => 'العربية';

  @override
  String get settingsLanguageEnglish => 'الإنجليزية';

  @override
  String get settingsSaveError => 'تعذر حفظ الإعدادات. حاول مرة أخرى.';

  @override
  String get settingsOfflineNote => 'تُحفظ الإعدادات على هذا الجهاز.';

  @override
  String get profileActivitySection => 'نشاطي';

  @override
  String get profileMyProfessionalFiles => 'ملفاتي المهنية';

  @override
  String get profileMyListings => 'إعلاناتي';

  @override
  String get profileMyReviews => 'تقييماتي';

  @override
  String get profileSupportSection => 'الدعم';

  @override
  String get profileHelpCenter => 'مركز المساعدة';

  @override
  String get profileContactUs => 'تواصل معنا';

  @override
  String get profileFaq => 'الأسئلة الشائعة';

  @override
  String get profilePrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get profileTerms => 'الشروط والأحكام';

  @override
  String get profileEmergencyTitle => 'في حالة الطوارئ';

  @override
  String get profileEmergencySubtitle => 'أرقام الطوارئ المهمة على مدار الساعة';

  @override
  String get profileEmergencySheetTitle => 'أرقام الطوارئ';

  @override
  String get profileEmergencyNote => 'الاتصال المباشر سيتوفر قريباً.';

  @override
  String get profileEmergencyAmbulance => 'الإسعاف';

  @override
  String get profileEmergencyPolice => 'الشرطة';

  @override
  String get profileEmergencyFire => 'المطافئ';

  @override
  String get profileLogout => 'تسجيل الخروج';

  @override
  String get profileLogoutConfirmTitle => 'تسجيل الخروج';

  @override
  String get profileLogoutConfirmMessage =>
      'هل أنت متأكد من رغبتك في تسجيل الخروج؟';

  @override
  String get profileLogoutUnavailable =>
      'لا توجد جلسة نشطة لتسجيل الخروج حالياً.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get profileErrorMessage => 'تعذر تحميل الملف الشخصي. حاول مرة أخرى.';

  @override
  String get offersTitle => 'عروض دكنرز 🎁';

  @override
  String get offersSubtitle => 'أفضل المنتجات والعروض من متاجر دكرنس';

  @override
  String get offersSearchHint => 'ابحث عن عرض...';

  @override
  String get offersAllCategory => 'الكل';

  @override
  String get offersSectionTitle => 'جميع العروض';

  @override
  String get offersEmptyMessage => 'لا توجد عروض متاحة حالياً.';

  @override
  String get offersNoSearchResults => 'لا توجد عروض مطابقة لبحثك.';

  @override
  String get offersErrorMessage => 'تعذر تحميل العروض. حاول مرة أخرى.';

  @override
  String get marketplaceTitle => 'سوق دكنرز';

  @override
  String get marketplaceSubtitle => 'أفضل المنتجات والعروض من متاجر دكرنس';

  @override
  String get marketplaceSearchHint => 'ابحث عن منتج أو عرض...';

  @override
  String get marketplaceSectionTitle => 'منتجات وعروض';

  @override
  String get marketplaceEmptyMessage => 'لا توجد منتجات متاحة حاليًا.';

  @override
  String get marketplaceNoSearchResults => 'لا توجد منتجات مطابقة لبحثك.';

  @override
  String get marketplaceErrorMessage => 'تعذر تحميل المنتجات. حاول مرة أخرى.';

  @override
  String get offersFeaturedBadge => 'مميز';

  @override
  String offersDiscountValue(int percent) {
    return 'خصم $percent%';
  }

  @override
  String offersExpiresOn(String date) {
    return 'ينتهي في $date';
  }

  @override
  String get offersAddFavorite => 'إضافة إلى المفضلة';

  @override
  String get offersRemoveFavorite => 'إزالة من المفضلة';

  @override
  String get offersFavoriteError => 'تعذر تحديث المفضلة. حاول مرة أخرى.';

  @override
  String get offersSortTooltip => 'ترتيب النتائج';

  @override
  String get offersSortTitle => 'ترتيب النتائج';

  @override
  String get offersSortRecommended => 'الأنسب';

  @override
  String get offersSortPriceLow => 'الأقل سعرًا';

  @override
  String get offersSortPriceHigh => 'الأعلى سعرًا';

  @override
  String get offersSortHighestDiscount => 'أعلى خصم';

  @override
  String get offersSortMostViewed => 'الأكثر مشاهدة';

  @override
  String get offersSellProduct => 'بيع منتج';

  @override
  String get offersSellUnavailable =>
      'إضافة المنتجات ستتوفر بعد ربط خدمة النشر.';

  @override
  String get offerDetailsTitle => 'تفاصيل العرض';

  @override
  String get offerDetailsDescriptionTitle => 'عن العرض';

  @override
  String get offerDetailsNotFound => 'لم يتم العثور على هذا العرض.';

  @override
  String get productDetailsTitle => 'تفاصيل المنتج';

  @override
  String get productDetailsDescriptionTitle => 'وصف المنتج';

  @override
  String get productDetailsNotFound => 'لم يتم العثور على هذا المنتج.';

  @override
  String get offerDetailsSave => 'إضافة إلى المفضلة';

  @override
  String get offerDetailsSaved => 'تمت الإضافة إلى المفضلة';

  @override
  String get offerDetailsDiscountLabel => 'الخصم';

  @override
  String get offerDetailsExpiryLabel => 'ينتهي في';

  @override
  String get offerDetailsViewsLabel => 'المشاهدات';

  @override
  String offerDetailsPublishedLabel(String date) {
    return 'نُشر في $date';
  }

  @override
  String get offerDetailsAvailabilityLabel => 'الحالة';

  @override
  String get offerDetailsAvailable => 'متوفر';

  @override
  String get offerDetailsUnavailable => 'غير متوفر';

  @override
  String get offerDetailsOriginalPriceLabel => 'السعر قبل الخصم';

  @override
  String offerGalleryCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get offerShareTooltip => 'نسخ معلومات المنتج';

  @override
  String get offerShareCopied => 'تم نسخ معلومات المنتج.';

  @override
  String get offerSellerTitle => 'معلومات البائع';

  @override
  String get offerSellerVerified => 'بائع موثّق';

  @override
  String offerSellerMemberSince(String year) {
    return 'عضو منذ $year';
  }

  @override
  String get offerContactCall => 'اتصال';

  @override
  String get offerContactWhatsapp => 'واتساب';

  @override
  String get offerContactUnavailable => 'رقم التواصل غير متوفر.';

  @override
  String get offerContactCopied => 'تم نسخ رقم التواصل.';

  @override
  String get offerCommentsTitle => 'التعليقات';

  @override
  String get offerCommentsEmpty => 'لا توجد تعليقات بعد.';

  @override
  String get offerCommentHint => 'أضف تعليقًا...';

  @override
  String get offerCommentSend => 'إرسال';

  @override
  String get offerCommentEmptyError => 'اكتب تعليقًا أولاً.';

  @override
  String get offerCommentUnavailable =>
      'إضافة التعليقات غير متاحة حتى يتم ربط خدمة التعليقات.';

  @override
  String get offerAiTitle => 'إرشاد ذكي';

  @override
  String get offerAiPreviewNote =>
      'معاينة محلية — لم يتم ربط خدمة التوصيات الذكية بعد.';

  @override
  String get offerAiStrongDiscount =>
      'خصم هذا العرض قوي. راجع تاريخ الانتهاء وتفاصيل البائع قبل الطلب.';

  @override
  String get offerAiCompare =>
      'قارن هذا العرض مع المنتجات المشابهة وتأكد من احتياجاتك قبل الطلب.';

  @override
  String get offerSimilarTitle => 'منتجات مشابهة';

  @override
  String get offerOrderNow => 'اطلب الآن';

  @override
  String get offerOrderUnavailableTitle => 'الطلب غير متاح';

  @override
  String get offerOrderUnavailableMessage =>
      'لم يتم ربط خدمة الطلبات بعد، ولم يتم إرسال أي طلب.';

  @override
  String get currencyEgp => 'ج.م';

  @override
  String get businessesTitle => 'الأعمال';

  @override
  String get pressBackAgainToExit => 'اضغط مرة أخرى للخروج من التطبيق';

  @override
  String get businessesAllLabel => 'الكل';

  @override
  String get businessesSearchHint => 'ابحث عن نشاط أو مكان...';

  @override
  String get businessesNoSearchResults => 'لا توجد أنشطة مطابقة لبحثك.';

  @override
  String get businessesCountLabel => 'نشاط';

  @override
  String get businessesAddCta => 'إضافة نشاط';

  @override
  String get businessesAddTitle => 'إضافة نشاط جديد';

  @override
  String get businessesFormName => 'اسم النشاط';

  @override
  String get businessesFormLocation => 'العنوان';

  @override
  String get businessesFormDescription => 'وصف مختصر';

  @override
  String get businessesFormPhone => 'رقم التواصل (اختياري)';

  @override
  String get businessesFormCategory => 'التصنيف';

  @override
  String get businessesFormRequired => 'هذا الحقل مطلوب.';

  @override
  String get businessesFormIntro =>
      'أدخل بيانات النشاط. لن يتم حفظها حتى يتم ربط خدمة النشر.';

  @override
  String get businessesFormSubmit => 'إرسال النشاط';

  @override
  String get businessesCreateUnavailableTitle => 'النشر غير متاح حاليًا';

  @override
  String get businessesCreateUnavailableMessage =>
      'تم التحقق من البيانات، لكن حفظ الأنشطة سيتوفر بعد ربط الـBackend.';

  @override
  String get businessesFormDiscardTitle => 'تجاهل التغييرات؟';

  @override
  String get businessesFormDiscardMessage =>
      'سيتم فقدان بيانات النشاط التي أدخلتها.';

  @override
  String get businessesFormDiscardConfirm => 'خروج';

  @override
  String get businessesFormContinue => 'متابعة التحرير';

  @override
  String get businessDetailsTitle => 'تفاصيل النشاط';

  @override
  String get businessAboutTitle => 'عن النشاط';

  @override
  String get businessLocationTitle => 'الموقع';

  @override
  String get businessContactTitle => 'التواصل';

  @override
  String get businessRatingLabel => 'التقييم';

  @override
  String get businessesEmpty => 'لا توجد أنشطة في هذا القسم حاليًا.';

  @override
  String get businessesErrorMessage => 'تعذر تحميل الأنشطة. حاول مرة أخرى.';

  @override
  String get businessesNotFound => 'لم يتم العثور على هذا النشاط.';

  @override
  String get businessContactUnavailable =>
      'لا توجد بيانات تواصل متاحة لهذا النشاط.';

  @override
  String get businessMapUnavailable =>
      'الموقع معروض كنص؛ الخريطة ستتوفر بعد ربط خدمة الخرائط.';

  @override
  String get jobsTitle => 'الوظائف';

  @override
  String get jobsVacanciesTab => 'الوظائف';

  @override
  String get jobsCandidatesTab => 'متاح للعمل';

  @override
  String get jobsSearchVacanciesHint => 'ابحث عن وظيفة أو شركة...';

  @override
  String get jobsSearchCandidatesHint => 'ابحث بالاسم أو المهارة...';

  @override
  String get jobsAllCategories => 'الكل';

  @override
  String get jobsFilters => 'الفلاتر';

  @override
  String get jobsClearFilters => 'مسح الفلاتر';

  @override
  String jobsResultsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count نتيجة',
      many: '$count نتيجة',
      few: '$count نتائج',
      two: 'نتيجتان',
      one: 'نتيجة واحدة',
      zero: 'لا توجد نتائج',
    );
    return '$_temp0';
  }

  @override
  String get jobsVacanciesEmpty => 'لا توجد وظائف متاحة حاليًا.';

  @override
  String get jobsCandidatesEmpty => 'لا يوجد أشخاص متاحون للعمل حاليًا.';

  @override
  String get jobsNoSearchResults => 'لا توجد نتائج مطابقة لبحثك أو فلاترك.';

  @override
  String get jobsErrorMessage => 'تعذر تحميل الوظائف. حاول مرة أخرى.';

  @override
  String get jobsFilterCategory => 'القسم';

  @override
  String get jobsFilterEmploymentType => 'نوع الوظيفة';

  @override
  String get jobsFilterAvailability => 'حالة الإتاحة';

  @override
  String get jobsFilterSort => 'الترتيب';

  @override
  String get jobsSortNewest => 'الأحدث';

  @override
  String get jobsSortSalaryHigh => 'الأعلى راتبًا';

  @override
  String get jobsSortSalaryLow => 'الأقل راتبًا';

  @override
  String get jobsSortExperienceHigh => 'الأكثر خبرة';

  @override
  String get jobsEmploymentFullTime => 'دوام كامل';

  @override
  String get jobsEmploymentPartTime => 'دوام جزئي';

  @override
  String get jobsEmploymentContract => 'عقد';

  @override
  String get jobsEmploymentInternship => 'تدريب';

  @override
  String get jobsEmploymentFreelance => 'عمل حر';

  @override
  String get jobsAvailabilityNow => 'متاح الآن';

  @override
  String get jobsAvailabilityOpen => 'منفتح على العروض';

  @override
  String get jobsApplyTitle => 'التقديم على الوظيفة';

  @override
  String get jobsApplyInstructions => 'طريقة التقديم';

  @override
  String get jobsContactTitle => 'التواصل';

  @override
  String get jobsContactCall => 'اتصال';

  @override
  String get jobsContactWhatsapp => 'واتساب';

  @override
  String get jobsContactEmail => 'البريد الإلكتروني';

  @override
  String get jobsContactUnavailable => 'لا توجد بيانات تواصل متاحة.';

  @override
  String get jobsContactCopied => 'تم نسخ بيانات التواصل.';

  @override
  String get jobsContactCopyNote =>
      'يتم نسخ بيانات التواصل؛ الاتصال المباشر غير متاح حتى يتم ربط خدمة الاتصال.';

  @override
  String get jobsCompanyTitle => 'عن الشركة';

  @override
  String get jobsDescriptionTitle => 'وصف الوظيفة';

  @override
  String get jobsResponsibilitiesTitle => 'المسؤوليات';

  @override
  String get jobsRequirementsTitle => 'المتطلبات';

  @override
  String get jobsExperienceLabel => 'الخبرة المطلوبة';

  @override
  String jobsExperienceYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years سنة',
      many: '$years سنة',
      few: '$years سنوات',
      two: 'سنتان',
      one: 'سنة واحدة',
      zero: 'أقل من سنة',
    );
    return '$_temp0';
  }

  @override
  String get jobsSalaryLabel => 'الراتب';

  @override
  String get jobsSalaryNotDisclosed => 'الراتب غير محدد';

  @override
  String jobsSalaryRange(String min, String max, String currency) {
    return '$min - $max $currency';
  }

  @override
  String jobsSalaryFrom(String min, String currency) {
    return 'من $min $currency';
  }

  @override
  String get jobsSalaryPerMonth => 'شهريًا';

  @override
  String get jobsSalaryPerDay => 'يوميًا';

  @override
  String get jobsSalaryPerHour => 'بالساعة';

  @override
  String get jobsSalaryPerYear => 'سنويًا';

  @override
  String get jobsPublishedLabel => 'تاريخ النشر';

  @override
  String get jobsPublishedToday => 'نُشر اليوم';

  @override
  String get jobsPublishedYesterday => 'نُشر أمس';

  @override
  String jobsPublishedDaysAgo(int count) {
    return 'نُشر منذ $count أيام';
  }

  @override
  String get jobsLocationLabel => 'الموقع';

  @override
  String get jobsCategoryLabel => 'القسم';

  @override
  String get jobsVerifiedEmployer => 'جهة عمل موثّقة';

  @override
  String get jobsFeaturedBadge => 'مميزة';

  @override
  String get jobsEmploymentTypeLabel => 'نوع الدوام';

  @override
  String get jobsViewDetails => 'عرض التفاصيل';

  @override
  String get jobsAddListing => 'إضافة إعلان';

  @override
  String get jobsCreateVacancyTitle => 'نشر وظيفة';

  @override
  String get jobsCreateCandidateTitle => 'إنشاء ملف للعمل';

  @override
  String get jobsCreateVacancySubtitle =>
      'املأ بيانات الوظيفة. لن يتم إرسال أي بيانات حتى يتم ربط خدمة النشر.';

  @override
  String get jobsCreateCandidateSubtitle =>
      'املأ بياناتك المهنية. لن يتم إرسال أي بيانات حتى يتم ربط خدمة النشر.';

  @override
  String get jobsCreateUnavailableTitle => 'النشر غير متاح';

  @override
  String get jobsCreateUnavailableMessage =>
      'لم يتم ربط خدمة نشر الوظائف بعد، ولم يتم إرسال أي بيانات.';

  @override
  String get jobsFormRequired => 'هذا الحقل مطلوب.';

  @override
  String get jobsFormTitleLabel => 'المسمى الوظيفي';

  @override
  String get jobsFormCompanyLabel => 'اسم الشركة';

  @override
  String get jobsFormDescriptionLabel => 'وصف الوظيفة';

  @override
  String get jobsFormResponsibilitiesLabel => 'المسؤوليات (سطر لكل بند)';

  @override
  String get jobsFormRequirementsLabel => 'المتطلبات (سطر لكل بند)';

  @override
  String get jobsFormCategoryLabel => 'القسم';

  @override
  String get jobsFormEmploymentTypeLabel => 'نوع الدوام';

  @override
  String get jobsFormSalaryMinLabel => 'أقل راتب';

  @override
  String get jobsFormSalaryMaxLabel => 'أعلى راتب';

  @override
  String get jobsFormLocationLabel => 'الموقع';

  @override
  String get jobsFormPhoneLabel => 'رقم التواصل';

  @override
  String get jobsFormEmailLabel => 'البريد الإلكتروني';

  @override
  String get jobsFormApplicationLabel => 'طريقة التقديم';

  @override
  String get jobsFormSubmit => 'إرسال الإعلان';

  @override
  String get jobsFormNameLabel => 'الاسم الكامل';

  @override
  String get jobsFormProfessionalTitleLabel => 'المسمى المهني';

  @override
  String get jobsFormSkillsLabel => 'المهارات (مفصولة بفواصل)';

  @override
  String get jobsFormExperienceYearsLabel => 'سنوات الخبرة';

  @override
  String get jobsFormPreferredLocationLabel => 'الموقع المفضل';

  @override
  String get jobsFormDesiredTypeLabel => 'نوع العمل المطلوب';

  @override
  String get jobsFormSummaryLabel => 'نبذة مهنية';

  @override
  String get jobsFormEducationLabel => 'التعليم';

  @override
  String get jobsFormCvLabel => 'السيرة الذاتية';

  @override
  String get jobsFormNumberInvalid => 'أدخل رقمًا صحيحًا.';

  @override
  String get jobsFormEmailInvalid => 'أدخل بريدًا إلكترونيًا صحيحًا.';

  @override
  String get jobsFormCvUnavailable =>
      'رفع السيرة الذاتية سيتوفر بعد ربط خدمة الملفات.';

  @override
  String get jobsFormDiscardTitle => 'تجاهل التغييرات؟';

  @override
  String get jobsFormDiscardMessage => 'لديك بيانات لم تُرسل. هل تريد الخروج؟';

  @override
  String get jobsFormDiscardConfirm => 'خروج';

  @override
  String get jobsFormContinue => 'متابعة التحرير';

  @override
  String get jobsCandidateSkillsTitle => 'المهارات';

  @override
  String get jobsCandidateExperienceTitle => 'الخبرة العملية';

  @override
  String get jobsCandidateEducationTitle => 'التعليم';

  @override
  String get jobsCandidateCertificatesTitle => 'الشهادات';

  @override
  String get jobsCandidateSummaryTitle => 'نبذة مهنية';

  @override
  String get jobsCandidateAvailabilityLabel => 'الإتاحة';

  @override
  String get jobsCandidateDesiredTypeLabel => 'نوع العمل المطلوب';

  @override
  String get jobsCandidatePreferredLocationLabel => 'الموقع المفضل';

  @override
  String get jobsCandidateCvTitle => 'السيرة الذاتية';

  @override
  String get jobsCandidateCvUnavailable =>
      'لم يتم إرفاق سيرة ذاتية، وتُعرض البيانات المهنية المتاحة بدلًا منها.';

  @override
  String get jobsDetailsTitle => 'تفاصيل الوظيفة';

  @override
  String get jobsCandidateDetailsTitle => 'الملف المهني';

  @override
  String get jobsDetailsNotFound => 'لم يتم العثور على هذا العنصر.';

  @override
  String get jobsFilterSheetTitle => 'تصفية النتائج';

  @override
  String get jobsApplyFilter => 'تطبيق';

  @override
  String get jobsReset => 'إعادة تعيين';

  @override
  String jobsFromTo(String from, String to) {
    return '$from - $to';
  }

  @override
  String get jobsPresent => 'حتى الآن';

  @override
  String get ok => 'حسنًا';
}
