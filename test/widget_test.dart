import 'dart:io';

import 'package:dikirnis_stor/app/app.dart';
import 'package:dikirnis_stor/features/businesses/presentation/pages/business_details_page.dart';
import 'package:dikirnis_stor/core/di/injection.dart';
import 'package:dikirnis_stor/features/categories/presentation/widgets/explore_promo_card.dart';
import 'package:dikirnis_stor/features/home/data/datasources/home_data_source.dart';
import 'package:dikirnis_stor/features/home/data/datasources/home_preview_data_source.dart';
import 'package:dikirnis_stor/features/home/presentation/cubit/home_cubit.dart';
import 'package:dikirnis_stor/features/home/presentation/pages/home_page.dart';
import 'package:dikirnis_stor/features/home/presentation/widgets/home_bottom_navigation_bar.dart';
import 'package:dikirnis_stor/features/home/presentation/widgets/home_header.dart';
import 'package:dikirnis_stor/features/jobs/data/datasources/jobs_data_source.dart';
import 'package:dikirnis_stor/features/jobs/data/datasources/jobs_preview_data_source.dart';
import 'package:dikirnis_stor/features/offers/data/datasources/offers_data_source.dart';
import 'package:dikirnis_stor/features/offers/data/datasources/offers_preview_data_source.dart';
import 'package:dikirnis_stor/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:dikirnis_stor/features/offers/presentation/cubit/offers_state.dart';
import 'package:dikirnis_stor/features/offers/presentation/pages/marketplace_page.dart';
import 'package:dikirnis_stor/features/offers/presentation/pages/offers_page.dart';
import 'package:dikirnis_stor/features/profile/data/datasources/profile_data_source.dart';
import 'package:dikirnis_stor/features/profile/data/datasources/profile_preview_data_source.dart';
import 'package:dikirnis_stor/features/settings/presentation/pages/settings_page.dart';
import 'package:dikirnis_stor/router/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TestAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) {
    final bytes = File(key).readAsBytesSync();
    return SynchronousFuture<ByteData>(ByteData.sublistView(bytes));
  }
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await getIt.reset();
    await configureDependencies();
    await getIt.unregister<HomeDataSource>();
    getIt.registerLazySingleton<HomeDataSource>(
      () => HomePreviewDataSource(
        bundle: _TestAssetBundle(),
        delay: Duration.zero,
      ),
    );
    await getIt.unregister<ProfileDataSource>();
    getIt.registerLazySingleton<ProfileDataSource>(
      () => ProfilePreviewDataSource(
        bundle: _TestAssetBundle(),
        delay: Duration.zero,
      ),
    );
    await getIt.unregister<OffersDataSource>();
    getIt.registerLazySingleton<OffersDataSource>(
      () => OffersPreviewDataSource(
        bundle: _TestAssetBundle(),
        delay: Duration.zero,
      ),
    );
    await getIt.unregister<JobsDataSource>();
    getIt.registerLazySingleton<JobsDataSource>(
      () => JobsPreviewDataSource(
        bundle: _TestAssetBundle(),
        delay: Duration.zero,
      ),
    );
  });

  void usePhoneSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  GoRouter useFreshRouter() {
    final router = createAppRouter();
    addTearDown(router.dispose);
    return router;
  }

  Future<void> pumpOffers(WidgetTester tester) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('العروض'));
    await tester.pumpAndSettle();
  }

  Future<void> pumpMarketplace(WidgetTester tester) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('السوق'));
    await tester.pumpAndSettle();
  }

  testWidgets('renders the English home shell with preview content', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('en'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Categories'), findsOneWidget);
    expect(find.textContaining('عبدالله عيطه'), findsOneWidget);
    expect(find.text('مطاعم وكافيهات'), findsOneWidget);
    expect(find.text('Most viewed this week'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('renders Arabic content with right-to-left direction', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    expect(find.text('الأقسام'), findsOneWidget);
    expect(find.text('مطاعم وكافيهات'), findsOneWidget);
    expect(find.text('الرئيسية'), findsOneWidget);

    final context = tester.element(find.byType(HomePage));
    expect(Directionality.of(context), TextDirection.rtl);
  });

  testWidgets('submits search text to the home cubit', (tester) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('en'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'مطعم');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(find.text('Full directory search is coming soon.'), findsOneWidget);

    final cubit = BlocProvider.of<HomeCubit>(
      tester.element(find.byType(HomeHeader)),
    );
    expect(cubit.state.searchQuery, 'مطعم');
  });

  testWidgets('renders the lower home sections without layout errors', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('en'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    final verticalScrollable = find
        .byWidgetPredicate(
          (widget) =>
              widget is Scrollable &&
              widget.axisDirection == AxisDirection.down,
        )
        .first;

    await tester.scrollUntilVisible(
      find.text('Medical sector'),
      300,
      scrollable: verticalScrollable,
    );
    expect(find.text('Medical sector'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Restaurants & cafes'),
      300,
      scrollable: verticalScrollable,
    );
    expect(find.text('Restaurants & cafes'), findsOneWidget);
  });

  testWidgets('dismisses the featured advertisement', (tester) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('en'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    final verticalScrollable = find
        .byWidgetPredicate(
          (widget) =>
              widget is Scrollable &&
              widget.axisDirection == AxisDirection.down,
        )
        .first;

    await tester.scrollUntilVisible(
      find.text('Crocodile'),
      250,
      scrollable: verticalScrollable,
    );
    await tester.tap(find.byTooltip('Dismiss advertisement'));
    await tester.pumpAndSettle();

    expect(find.text('Crocodile'), findsNothing);
  });

  testWidgets('opens the profile screen from the bottom navigation', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('الملف الشخصي'));
    await tester.pumpAndSettle();

    expect(find.text('أحمد محمود'), findsOneWidget);
    expect(find.text('الحساب'), findsOneWidget);
    expect(find.text('نشاطي'), findsOneWidget);

    final navigationBar = tester.widget<HomeBottomNavigationBar>(
      find.byType(HomeBottomNavigationBar),
    );
    expect(navigationBar.selectedIndex, 4);

    final verticalScrollable = find
        .byWidgetPredicate(
          (widget) =>
              widget is Scrollable &&
              widget.axisDirection == AxisDirection.down,
        )
        .first;

    await tester.scrollUntilVisible(
      find.text('الدعم'),
      300,
      scrollable: verticalScrollable,
    );
    expect(find.text('الدعم'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('تسجيل الخروج'),
      300,
      scrollable: verticalScrollable,
    );
    expect(find.text('تسجيل الخروج'), findsOneWidget);
    expect(find.text('في حالة الطوارئ'), findsOneWidget);
  });

  testWidgets('opens the explore screen from the bottom navigation', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('الاستكشافات'));
    await tester.pumpAndSettle();

    expect(find.text('الفئات'), findsOneWidget);
    expect(find.text('جميع الأقسام'), findsOneWidget);
    expect(find.text('القطاع الطبي'), findsOneWidget);
    expect(find.text('المطاعم والكافيهات'), findsOneWidget);
    expect(find.text('2 قسم فرعي'), findsOneWidget);

    final verticalScrollable = find
        .byWidgetPredicate(
          (widget) =>
              widget is Scrollable &&
              widget.axisDirection == AxisDirection.down,
        )
        .first;

    await tester.scrollUntilVisible(
      find.text('أسعار السوق'),
      300,
      scrollable: verticalScrollable,
    );
    expect(find.text('المزيد'), findsOneWidget);
    expect(find.text('الأخبار'), findsOneWidget);
    expect(find.text('أسعار السوق'), findsOneWidget);
    expect(find.text('التوظيف'), findsOneWidget);
    expect(find.byType(ExplorePromoCard), findsNWidgets(4));
  });

  testWidgets('opens the original offers screen from the bottom navigation', (
    tester,
  ) async {
    await pumpOffers(tester);

    expect(find.text('عروض دكنرز 🎁'), findsOneWidget);
    expect(find.text('جميع العروض'), findsOneWidget);
    expect(find.text('خصم 40% على دورات البرمجة'), findsOneWidget);

    final navigationBar = tester.widget<HomeBottomNavigationBar>(
      find.byType(HomeBottomNavigationBar),
    );
    expect(navigationBar.selectedIndex, 3);

    final context = tester.element(find.byType(OffersPage));
    expect(Directionality.of(context), TextDirection.rtl);
  });

  testWidgets('filters offers by search text', (tester) async {
    await pumpOffers(tester);

    await tester.enterText(find.byType(TextField), 'برمجة');
    await tester.pumpAndSettle();

    expect(find.text('خصم 40% على دورات البرمجة'), findsOneWidget);
    expect(find.text('خصم 25% على العناية بالشعر'), findsNothing);

    final cubit = BlocProvider.of<OffersCubit>(
      tester.element(find.byType(OffersPage)),
    );
    expect(cubit.state.query, 'برمجة');

    await tester.enterText(find.byType(TextField), 'اتصالات');
    await tester.pumpAndSettle();

    expect(find.text('لا توجد عروض مطابقة لبحثك.'), findsOneWidget);
  });

  testWidgets('filters offers by category and preserves the filter', (
    tester,
  ) async {
    await pumpOffers(tester);

    await tester.tap(find.byKey(const ValueKey('offer_category_beauty')));
    await tester.pumpAndSettle();

    expect(find.text('خصم 25% على العناية بالشعر'), findsOneWidget);
    expect(find.text('خصم 40% على دورات البرمجة'), findsNothing);

    final cubit = BlocProvider.of<OffersCubit>(
      tester.element(find.byType(OffersPage)),
    );
    expect(cubit.state.selectedCategoryId, 'beauty');
  });

  testWidgets('opens original offer details and toggles a favorite', (
    tester,
  ) async {
    await pumpOffers(tester);

    await tester.tap(find.text('خصم 40% على دورات البرمجة'));
    await tester.pumpAndSettle();

    expect(find.text('تفاصيل العرض'), findsOneWidget);
    expect(find.text('مركز تكنو للتدريب'), findsWidgets);
    expect(find.text('عن العرض'), findsOneWidget);
    expect(find.text('تفاصيل المنتج'), findsNothing);
    expect(find.byTooltip('إضافة إلى المفضلة'), findsOneWidget);

    await tester.tap(find.byTooltip('إضافة إلى المفضلة'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('إزالة من المفضلة'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_forward_rounded));
    await tester.pumpAndSettle();

    expect(find.text('عروض دكنرز 🎁'), findsOneWidget);
    expect(find.byTooltip('إزالة من المفضلة'), findsOneWidget);
  });

  testWidgets('opens the marketplace from the middle navigation icon', (
    tester,
  ) async {
    await pumpMarketplace(tester);

    expect(find.text('سوق دكنرز'), findsOneWidget);
    expect(find.text('منتجات وعروض'), findsOneWidget);
    expect(find.text('خصم 40% على دورات البرمجة'), findsOneWidget);

    final navigationBar = tester.widget<HomeBottomNavigationBar>(
      find.byType(HomeBottomNavigationBar),
    );
    expect(navigationBar.selectedIndex, 2);

    final context = tester.element(find.byType(MarketplacePage));
    expect(Directionality.of(context), TextDirection.rtl);
  });

  testWidgets('filters marketplace products by search text', (tester) async {
    await pumpMarketplace(tester);

    await tester.enterText(find.byType(TextField), 'برمجة');
    await tester.pumpAndSettle();

    expect(find.text('خصم 40% على دورات البرمجة'), findsOneWidget);
    expect(find.text('خصم 25% على العناية بالشعر'), findsNothing);

    final cubit = BlocProvider.of<OffersCubit>(
      tester.element(find.byType(MarketplacePage)),
    );
    expect(cubit.state.query, 'برمجة');

    await tester.enterText(find.byType(TextField), 'اتصالات');
    await tester.pumpAndSettle();

    expect(find.text('لا توجد منتجات مطابقة لبحثك.'), findsOneWidget);
  });

  testWidgets('sorts the product grid from the sort sheet', (tester) async {
    await pumpMarketplace(tester);

    await tester.tap(find.byKey(const ValueKey('marketplace_sort_button')));
    await tester.pumpAndSettle();

    expect(find.text('ترتيب النتائج'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('offer_sort_priceLowHigh')));
    await tester.pump(const Duration(milliseconds: 500));

    final cubit = BlocProvider.of<OffersCubit>(
      tester.element(find.byType(MarketplacePage)),
    );
    expect(cubit.state.sort, OffersSort.priceLowHigh);
    expect(cubit.state.offers.first.id, 'offer_fast_delivery');
  });

  testWidgets('shows product details, seller, comments, and order actions', (
    tester,
  ) async {
    await pumpMarketplace(tester);

    await tester.tap(find.text('خصم 40% على دورات البرمجة'));
    await tester.pumpAndSettle();

    expect(find.text('تفاصيل المنتج'), findsOneWidget);

    final verticalScrollable = find
        .byWidgetPredicate(
          (widget) =>
              widget is Scrollable &&
              widget.axisDirection == AxisDirection.down,
        )
        .first;

    await tester.scrollUntilVisible(
      find.text('معلومات البائع'),
      300,
      scrollable: verticalScrollable,
    );
    expect(find.text('معلومات البائع'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('إرشاد ذكي'),
      300,
      scrollable: verticalScrollable,
    );
    expect(find.text('إرشاد ذكي'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('التعليقات'),
      300,
      scrollable: verticalScrollable,
    );
    expect(find.text('التعليقات'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('دورة منظمة وشرح واضح، استفدت منها في مشروعي الأول.'),
      300,
      scrollable: verticalScrollable,
    );
    expect(
      find.text('دورة منظمة وشرح واضح، استفدت منها في مشروعي الأول.'),
      findsOneWidget,
    );

    await tester.ensureVisible(
      find.byKey(const ValueKey('offer_comment_field')),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('offer_comment_send')));
    await tester.pumpAndSettle();

    expect(find.text('اكتب تعليقًا أولاً.'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('offer_comment_field')),
      'تعليق تجريبي',
    );
    await tester.tap(find.byKey(const ValueKey('offer_comment_send')));
    await tester.pumpAndSettle();

    expect(
      find.text('إضافة التعليقات غير متاحة حتى يتم ربط خدمة التعليقات.'),
      findsWidgets,
    );
    expect(find.text('تعليق تجريبي'), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('offer_order_now')));
    await tester.pumpAndSettle();

    expect(find.text('الطلب غير متاح'), findsOneWidget);
    expect(
      find.text('لم يتم ربط خدمة الطلبات بعد، ولم يتم إرسال أي طلب.'),
      findsOneWidget,
    );
  });

  testWidgets('shows similar products for the same category', (tester) async {
    await pumpMarketplace(tester);

    await tester.enterText(find.byType(TextField), 'الفحوصات');
    await tester.pumpAndSettle();
    await tester.tap(find.text('خصم 20% على الفحوصات الشاملة'));
    await tester.pumpAndSettle();

    final verticalScrollable = find
        .byWidgetPredicate(
          (widget) =>
              widget is Scrollable &&
              widget.axisDirection == AxisDirection.down,
        )
        .first;

    await tester.scrollUntilVisible(
      find.text('منتجات مشابهة'),
      300,
      scrollable: verticalScrollable,
    );

    expect(find.text('منتجات مشابهة'), findsOneWidget);
    expect(find.text('عيادة د. سارة للأسنان'), findsWidgets);
  });

  testWidgets('navigates between offers, marketplace, and profile', (
    tester,
  ) async {
    await pumpOffers(tester);

    await tester.tap(find.text('الملف الشخصي'));
    await tester.pumpAndSettle();

    expect(find.text('بياناتي الشخصية'), findsOneWidget);

    await tester.tap(find.byTooltip('السوق'));
    await tester.pumpAndSettle();

    expect(find.text('سوق دكنرز'), findsOneWidget);

    await tester.tap(find.text('العروض'));
    await tester.pumpAndSettle();

    expect(find.text('عروض دكنرز 🎁'), findsOneWidget);
  });

  testWidgets('preserves tab state when switching branches', (tester) async {
    await pumpOffers(tester);

    await tester.enterText(find.byType(TextField), 'برمجة');
    await tester.pumpAndSettle();

    await tester.tap(find.text('الملف الشخصي'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('العروض'));
    await tester.pumpAndSettle();

    final cubit = BlocProvider.of<OffersCubit>(
      tester.element(find.byType(OffersPage)),
    );
    expect(cubit.state.query, 'برمجة');
    expect(find.text('خصم 40% على دورات البرمجة'), findsOneWidget);
    expect(find.text('خصم 25% على العناية بالشعر'), findsNothing);
  });

  testWidgets('requires two back presses before exiting the app', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    final platformCalls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        platformCalls.add(call);
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await tester.binding.handlePopRoute();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('اضغط مرة أخرى للخروج من التطبيق'), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
    expect(
      platformCalls.where((call) => call.method == 'SystemNavigator.pop'),
      isEmpty,
    );

    await tester.binding.handlePopRoute();
    await tester.pump();

    expect(
      platformCalls.where((call) => call.method == 'SystemNavigator.pop'),
      isNotEmpty,
    );
  });

  testWidgets('returns to home when back is pressed on another tab', (
    tester,
  ) async {
    await pumpOffers(tester);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    final navigationBar = tester.widget<HomeBottomNavigationBar>(
      find.byType(HomeBottomNavigationBar),
    );
    expect(navigationBar.selectedIndex, 0);
  });

  testWidgets('renders the shell at a large text scale without overflow', (
    tester,
  ) async {
    usePhoneSurface(tester);
    tester.platformDispatcher.textScaleFactorTestValue = 1.6;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('الاستكشافات'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('العروض'));
    await tester.pumpAndSettle();

    final navigationBar = tester.widget<HomeBottomNavigationBar>(
      find.byType(HomeBottomNavigationBar),
    );
    expect(navigationBar.selectedIndex, 3);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders product details at a large text scale', (tester) async {
    usePhoneSurface(tester);
    tester.platformDispatcher.textScaleFactorTestValue = 1.6;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('السوق'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('خصم 40% على دورات البرمجة'));
    await tester.pumpAndSettle();

    expect(find.text('تفاصيل المنتج'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens settings and applies language and theme preferences', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(DikirnisApp(router: useFreshRouter()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsPage), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('settings_language_arabic')));
    await tester.pumpAndSettle();

    final settingsContext = tester.element(find.byType(SettingsPage));
    expect(Directionality.of(settingsContext), TextDirection.rtl);

    await tester.tap(find.byKey(const ValueKey('settings_theme_dark')));
    await tester.pumpAndSettle();

    final themedContext = tester.element(find.byType(SettingsPage));
    expect(Theme.of(themedContext).brightness, Brightness.dark);

    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString('settings.language'), 'arabic');
    expect(preferences.getString('settings.theme'), 'dark');
  });

  Future<void> pumpJobs(WidgetTester tester) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('التوظيف'));
    await tester.pumpAndSettle();
  }

  testWidgets('opens jobs from home, switches tabs, and searches', (
    tester,
  ) async {
    await pumpJobs(tester);

    expect(find.text('الوظائف'), findsWidgets);
    expect(find.text('باريستا'), findsOneWidget);
    expect(find.text('مدرس رياضيات'), findsOneWidget);

    await tester.tap(find.text('متاح للعمل'));
    await tester.pumpAndSettle();

    expect(find.text('عمر حسن'), findsOneWidget);
    expect(find.text('أحمد محمود'), findsOneWidget);
    expect(find.text('باريستا'), findsNothing);

    await tester.enterText(find.byType(TextField), 'أحمد');
    await tester.pumpAndSettle();

    expect(find.text('أحمد محمود'), findsOneWidget);
    expect(find.text('عمر حسن'), findsNothing);
    expect(find.text('نتيجة واحدة'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'غير موجود');
    await tester.pumpAndSettle();

    expect(find.text('لا توجد نتائج مطابقة لبحثك أو فلاترك.'), findsOneWidget);
  });

  testWidgets('opens vacancy details with contact actions', (tester) async {
    await pumpJobs(tester);

    await tester.tap(find.text('باريستا'));
    await tester.pumpAndSettle();

    expect(find.text('تفاصيل الوظيفة'), findsOneWidget);
    expect(find.text('وصف الوظيفة'), findsOneWidget);
    expect(find.text('التواصل'), findsOneWidget);
    expect(
      find.textContaining('نُشر اليوم', findRichText: true),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('job_contact_whatsapp')), findsOneWidget);
    expect(
      find.text(
        'يتم نسخ بيانات التواصل؛ الاتصال المباشر غير متاح حتى يتم ربط خدمة الاتصال.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('opens candidate details with professional sections', (
    tester,
  ) async {
    await pumpJobs(tester);
    await tester.tap(find.text('متاح للعمل'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('عمر حسن'));
    await tester.pumpAndSettle();

    expect(find.text('الملف المهني'), findsOneWidget);
    expect(find.text('المهارات'), findsOneWidget);

    final detailsScrollable = find
        .descendant(
          of: find.byType(ListView),
          matching: find.byType(Scrollable),
        )
        .first;

    await tester.scrollUntilVisible(
      find.text('الخبرة العملية'),
      300,
      scrollable: detailsScrollable,
    );
    expect(find.text('الخبرة العملية'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('السيرة الذاتية'),
      300,
      scrollable: detailsScrollable,
    );
    expect(find.text('السيرة الذاتية'), findsOneWidget);
    expect(
      find.text(
        'لم يتم إرفاق سيرة ذاتية، وتُعرض البيانات المهنية المتاحة بدلًا منها.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('opens the medical directory and business details', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('القطاع الطبي').first);
    await tester.pumpAndSettle();

    expect(find.text('مركز الشفاء الطبي'), findsOneWidget);
    expect(find.text('عيادات باطنة وأطفال وأشعة'), findsOneWidget);

    await tester.tap(find.text('مركز الشفاء الطبي'));
    await tester.pumpAndSettle();

    expect(find.text('تفاصيل النشاط'), findsOneWidget);
    expect(find.text('عن النشاط'), findsOneWidget);

    final detailsScrollable = find
        .descendant(
          of: find.byType(BusinessDetailsPage),
          matching: find.byType(Scrollable),
        )
        .first;

    await tester.scrollUntilVisible(
      find.text('الموقع معروض كنص؛ الخريطة ستتوفر بعد ربط خدمة الخرائط.'),
      250,
      scrollable: detailsScrollable,
    );
    expect(
      find.text('الموقع معروض كنص؛ الخريطة ستتوفر بعد ربط خدمة الخرائط.'),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(
      find.text('التواصل'),
      250,
      scrollable: detailsScrollable,
    );
    expect(find.text('التواصل'), findsOneWidget);
    expect(
      find.text('لا توجد بيانات تواصل متاحة لهذا النشاط.'),
      findsOneWidget,
    );
  });

  testWidgets('opens the restaurants directory from a home category', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('مطاعم وكافيهات').first);
    await tester.pumpAndSettle();

    expect(find.text('مطاعم وكافيهات'), findsWidgets);
    expect(find.text('أسماك النيل'), findsOneWidget);

    await tester.tap(find.text('أسماك النيل'));
    await tester.pumpAndSettle();

    expect(find.text('تفاصيل النشاط'), findsOneWidget);
    expect(find.text('مأكولات بحرية طازجة ومشويات'), findsOneWidget);
  });

  testWidgets('opens a business category directory and filters it', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('المبيعات التجارية').first);
    await tester.pumpAndSettle();

    expect(find.text('المبيعات التجارية'), findsWidgets);
    expect(find.text('تكنو ستور'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('businesses_category_all')));
    await tester.pumpAndSettle();

    expect(find.text('الأعمال'), findsOneWidget);
    expect(find.text('تكنو ستور'), findsOneWidget);

    await tester.tap(
      find.byKey(const ValueKey('businesses_category_commercial_sales')),
    );
    await tester.pumpAndSettle();

    expect(find.text('تكنو ستور'), findsOneWidget);

    await tester.tap(find.text('تكنو ستور'));
    await tester.pumpAndSettle();

    expect(find.text('تفاصيل النشاط'), findsOneWidget);
    expect(
      find.text('أجهزة كهربائية وإلكترونيات وخدمة ما بعد البيع'),
      findsOneWidget,
    );

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('businesses_search')),
      'الأمانة',
    );
    await tester.pumpAndSettle();

    expect(find.text('سوبرماركت الأمانة'), findsOneWidget);
    expect(find.text('تكنو ستور'), findsNothing);

    await tester.enterText(
      find.byKey(const ValueKey('businesses_search')),
      'غير موجود',
    );
    await tester.pumpAndSettle();

    expect(find.text('لا توجد أنشطة مطابقة لبحثك.'), findsOneWidget);
  });

  testWidgets('validates a new business and shows the unavailable notice', (
    tester,
  ) async {
    usePhoneSurface(tester);
    await tester.pumpWidget(
      DikirnisApp(locale: const Locale('ar'), router: useFreshRouter()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('المبيعات التجارية').first);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('businesses_add_button')));
    await tester.pumpAndSettle();

    expect(find.text('إضافة نشاط جديد'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('businesses_form_category')),
      findsOneWidget,
    );
    expect(
      find.text('أدخل بيانات النشاط. لن يتم حفظها حتى يتم ربط خدمة النشر.'),
      findsOneWidget,
    );

    await tester.ensureVisible(
      find.byKey(const ValueKey('businesses_form_submit')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('businesses_form_submit')));
    await tester.pumpAndSettle();

    expect(find.text('هذا الحقل مطلوب.'), findsWidgets);

    await tester.enterText(
      find.byKey(const ValueKey('businesses_form_name')),
      'محل تجريبي',
    );
    await tester.enterText(
      find.byKey(const ValueKey('businesses_form_location')),
      'شارع الجيش',
    );
    await tester.enterText(
      find.byKey(const ValueKey('businesses_form_description')),
      'وصف مختصر للنشاط',
    );
    await tester.ensureVisible(
      find.byKey(const ValueKey('businesses_form_submit')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('businesses_form_submit')));
    await tester.pumpAndSettle();

    expect(find.text('النشر غير متاح حاليًا'), findsOneWidget);
    expect(
      find.text(
        'تم التحقق من البيانات، لكن حفظ الأنشطة سيتوفر بعد ربط الـBackend.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('validates the create form and warns before discarding', (
    tester,
  ) async {
    await pumpJobs(tester);

    await tester.tap(find.byKey(const ValueKey('jobs_fab')));
    await tester.pumpAndSettle();

    expect(find.text('نشر وظيفة'), findsOneWidget);
    expect(find.text('إرسال الإعلان'), findsOneWidget);
    expect(
      find.text(
        'املأ بيانات الوظيفة. لن يتم إرسال أي بيانات حتى يتم ربط خدمة النشر.',
      ),
      findsOneWidget,
    );

    await tester.ensureVisible(find.byKey(const ValueKey('jobs_form_submit')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('jobs_form_submit')));
    await tester.pumpAndSettle();

    expect(find.text('هذا الحقل مطلوب.'), findsWidgets);

    await tester.enterText(
      find.byKey(const ValueKey('jobs_form_title')),
      'وظيفة تجريبية',
    );
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('تجاهل التغييرات؟'), findsOneWidget);

    await tester.tap(find.text('خروج'));
    await tester.pumpAndSettle();

    expect(find.text('الوظائف'), findsWidgets);
    expect(find.text('إضافة إعلان'), findsOneWidget);
  });
}
