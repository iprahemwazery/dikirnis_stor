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
  String get ok => 'حسنًا';
}
