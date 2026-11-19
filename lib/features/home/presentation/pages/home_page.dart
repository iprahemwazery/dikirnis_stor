import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/app_error_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../router/app_routes.dart';
import '../../../../theme/app_spacing.dart';
import '../../domain/entities/business.dart';
import '../../domain/entities/home_advertisement.dart';
import '../../domain/entities/home_banner.dart';
import '../../domain/entities/home_category.dart';
import '../../domain/entities/home_content.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/business_horizontal_list.dart';
import '../widgets/category_grid.dart';
import '../widgets/featured_advertisement_card.dart';
import '../widgets/home_banner_carousel.dart';
import '../widgets/home_header.dart';
import '../widgets/home_loading_view.dart';
import '../widgets/home_section_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Duration _exitWindow = Duration(seconds: 2);

  DateTime? _lastBackPress;

  void _handleBackPress() {
    final now = DateTime.now();
    final lastPress = _lastBackPress;
    if (lastPress != null && now.difference(lastPress) < _exitWindow) {
      _lastBackPress = null;
      SystemNavigator.pop();
      return;
    }

    _lastBackPress = now;
    _showMessage(context, context.l10n.pressBackAgainToExit);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleBackPress();
        }
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocListener<HomeCubit, HomeState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == HomeStatus.failure,
            listener: (context, state) {
              if (state.content == null) {
                return;
              }
              _showMessage(context, l10n.homeErrorMessage);
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status ||
                  previous.content != current.content ||
                  previous.advertisementDismissed !=
                      current.advertisementDismissed,
              builder: (context, state) {
                if (state.content == null) {
                  if (state.status == HomeStatus.failure) {
                    return AppErrorState(
                      message: l10n.homeErrorMessage,
                      retryLabel: l10n.retry,
                      onRetry: () =>
                          context.read<HomeCubit>().load(force: true),
                    );
                  }
                  return const HomeLoadingView();
                }

                if (state.status == HomeStatus.empty) {
                  return AppEmptyState(
                    message: l10n.homeEmptyMessage,
                    icon: Icons.storefront_outlined,
                  );
                }

                return _HomeContentView(
                  content: state.content!,
                  advertisement: state.advertisement,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeContentView extends StatelessWidget {
  const _HomeContentView({required this.content, required this.advertisement});

  final HomeContent content;
  final HomeAdvertisement? advertisement;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<HomeCubit>();
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final listHeightDelta = (textScale - 1).clamp(0.0, 2.0);

    void showComingSoon() {
      _showMessage(context, l10n.comingSoonMessage);
    }

    void handleSearch(String query) {
      cubit.submitSearch(query);
      _showMessage(context, l10n.searchComingSoonMessage);
    }

    void handleBanner(HomeBanner banner) {
      showComingSoon();
    }

    void openBusinesses(String section) {
      context.push(AppRoutes.businessDirectoryPath(section));
    }

    void handleCategory(HomeCategory category) {
      if (category.id == 'jobs') {
        context.push(AppRoutes.jobs);
        return;
      }
      if (category.isMore || category.id == 'more') {
        context.go(AppRoutes.explore);
        return;
      }
      openBusinesses(category.id);
    }

    void handleBusiness(Business business) {
      context.push(AppRoutes.businessDetailsPath(business.id));
    }

    return RefreshIndicator(
      onRefresh: cubit.refresh,
      color: Theme.of(context).colorScheme.primary,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: HomeHeader(
              userName: content.userName,
              userLocation: content.userLocation,
              onSearchSubmitted: handleSearch,
              onNotificationsTap: showComingSoon,
              onMessagesTap: showComingSoon,
            ),
          ),
          if (content.banners.isNotEmpty)
            SliverToBoxAdapter(
              child: HomeBannerCarousel(
                banners: content.banners,
                onBannerTap: handleBanner,
                onMoreTap: showComingSoon,
              ),
            ),
          if (content.categories.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: HomeSectionHeader(
                title: l10n.homeCategoriesTitle,
                topPadding: AppSpacing.md,
              ),
            ),
            SliverToBoxAdapter(
              child: CategoryGrid(
                categories: content.categories,
                onCategoryTap: handleCategory,
              ),
            ),
          ],
          if (content.mostViewed.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: HomeSectionHeader(title: l10n.mostViewedTitle),
            ),
            SliverToBoxAdapter(
              child: BusinessHorizontalList(
                businesses: content.mostViewed,
                height: 200 + listHeightDelta * 70,
                cardWidth: 198,
                imageHeight: 110,
                showViews: true,
                onBusinessTap: handleBusiness,
              ),
            ),
          ],
          if (advertisement != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  0,
                ),
                child: FeaturedAdvertisementCard(
                  advertisement: advertisement!,
                  onTap: showComingSoon,
                  onDismiss: cubit.dismissAdvertisement,
                ),
              ),
            ),
          if (content.recentlyAdded.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: HomeSectionHeader(title: l10n.recentlyAddedTitle),
            ),
            SliverToBoxAdapter(
              child: BusinessHorizontalList(
                businesses: content.recentlyAdded,
                height: 212 + listHeightDelta * 70,
                cardWidth: 208,
                imageHeight: 116,
                onBusinessTap: handleBusiness,
              ),
            ),
          ],
          if (content.medical.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: HomeSectionHeader(
                title: l10n.medicalSectorTitle,
                actionLabel: l10n.viewAll,
                onAction: () => openBusinesses('medical'),
              ),
            ),
            SliverToBoxAdapter(
              child: BusinessHorizontalList(
                businesses: content.medical,
                height: 242 + listHeightDelta * 90,
                cardWidth: 260,
                imageHeight: 118,
                showDescription: true,
                onBusinessTap: handleBusiness,
              ),
            ),
          ],
          if (content.restaurants.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: HomeSectionHeader(
                title: l10n.restaurantsCafesTitle,
                actionLabel: l10n.viewAll,
                onAction: () => openBusinesses('restaurants_cafes'),
              ),
            ),
            SliverToBoxAdapter(
              child: BusinessHorizontalList(
                businesses: content.restaurants,
                height: 238 + listHeightDelta * 90,
                cardWidth: 244,
                imageHeight: 112,
                showDescription: true,
                onBusinessTap: handleBusiness,
              ),
            ),
          ],
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),
        ],
      ),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
