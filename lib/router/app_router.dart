import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../app/main_shell.dart';
import '../core/di/injection.dart';
import '../core/widgets/app_empty_state.dart';
import '../features/categories/presentation/cubit/categories_cubit.dart';
import '../features/categories/presentation/pages/explore_page.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/offers/presentation/cubit/offer_details_cubit.dart';
import '../features/offers/presentation/cubit/offers_cubit.dart';
import '../features/offers/presentation/pages/marketplace_page.dart';
import '../features/offers/presentation/pages/offer_details_page.dart';
import '../features/offers/presentation/pages/offers_page.dart';
import '../features/offers/presentation/pages/product_details_page.dart';
import '../features/profile/presentation/cubit/profile_cubit.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../l10n/l10n.dart';
import 'app_routes.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      StatefulShellRoute.indexedStack(
        restorationScopeId: 'main-shell',
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            restorationScopeId: 'home-branch',
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) {
                  return BlocProvider<HomeCubit>(
                    create: (_) => getIt<HomeCubit>()..load(),
                    child: const HomePage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            restorationScopeId: 'explore-branch',
            routes: [
              GoRoute(
                path: AppRoutes.explore,
                name: 'explore',
                builder: (context, state) {
                  return BlocProvider<CategoriesCubit>(
                    create: (_) => getIt<CategoriesCubit>()..load(),
                    child: const ExplorePage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            restorationScopeId: 'marketplace-branch',
            routes: [
              GoRoute(
                path: AppRoutes.marketplace,
                name: 'marketplace',
                builder: (context, state) {
                  return BlocProvider<OffersCubit>(
                    create: (_) => getIt<OffersCubit>()..load(),
                    child: const MarketplacePage(),
                  );
                },
                routes: [
                  GoRoute(
                    path: ':offerId',
                    name: 'productDetails',
                    builder: (context, state) {
                      final offerId = state.pathParameters['offerId']!;
                      return BlocProvider<OfferDetailsCubit>(
                        create: (_) =>
                            getIt<OfferDetailsCubit>()..load(offerId),
                        child: ProductDetailsPage(offerId: offerId),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            restorationScopeId: 'offers-branch',
            routes: [
              GoRoute(
                path: AppRoutes.offers,
                name: 'offers',
                builder: (context, state) {
                  return BlocProvider<OffersCubit>(
                    create: (_) => getIt<OffersCubit>()..load(),
                    child: const OffersPage(),
                  );
                },
                routes: [
                  GoRoute(
                    path: ':offerId',
                    name: 'offerDetails',
                    builder: (context, state) {
                      final offerId = state.pathParameters['offerId']!;
                      return BlocProvider<OfferDetailsCubit>(
                        create: (_) =>
                            getIt<OfferDetailsCubit>()..load(offerId),
                        child: OfferDetailsPage(offerId: offerId),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            restorationScopeId: 'profile-branch',
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                builder: (context, state) {
                  return BlocProvider<ProfileCubit>(
                    create: (_) => getIt<ProfileCubit>()..load(),
                    child: const ProfilePage(),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'settings',
                    name: 'settings',
                    builder: (context, state) => const SettingsPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const _RouteErrorPage(),
  );
}

final GoRouter appRouter = createAppRouter();

class _RouteErrorPage extends StatelessWidget {
  const _RouteErrorPage();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: AppEmptyState(
          icon: Icons.explore_off_rounded,
          title: l10n.pageNotFoundTitle,
          message: l10n.pageNotFoundMessage,
          actionLabel: l10n.backToHome,
          onAction: () => context.go(AppRoutes.home),
        ),
      ),
    );
  }
}
