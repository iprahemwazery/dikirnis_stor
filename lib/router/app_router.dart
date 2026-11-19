import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../app/main_shell.dart';
import '../core/di/injection.dart';
import '../core/widgets/app_empty_state.dart';
import '../features/businesses/presentation/cubit/business_details_cubit.dart';
import '../features/businesses/presentation/pages/business_create_page.dart';
import '../features/businesses/presentation/pages/business_details_page.dart';
import '../features/businesses/presentation/pages/business_directory_page.dart';
import '../features/categories/presentation/cubit/categories_cubit.dart';
import '../features/categories/presentation/pages/explore_page.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/jobs/presentation/cubit/job_details_cubit.dart';
import '../features/jobs/presentation/cubit/jobs_cubit.dart';
import '../features/jobs/presentation/cubit/jobs_state.dart';
import '../features/jobs/presentation/pages/candidate_details_page.dart';
import '../features/jobs/presentation/pages/job_create_page.dart';
import '../features/jobs/presentation/pages/job_details_page.dart';
import '../features/jobs/presentation/pages/jobs_page.dart';
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
              GoRoute(
                path: AppRoutes.businesses,
                name: 'businessDirectory',
                builder: (context, state) {
                  final categoryId =
                      state.uri.queryParameters['section'] ?? 'medical';
                  return BlocProvider<HomeCubit>(
                    create: (_) => getIt<HomeCubit>()..load(),
                    child: BusinessDirectoryPage(categoryId: categoryId),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'create',
                    name: 'businessCreate',
                    builder: (context, state) {
                      final categoryId =
                          state.uri.queryParameters['category'] ?? 'medical';
                      return BlocProvider<HomeCubit>(
                        create: (_) => getIt<HomeCubit>()..load(),
                        child: BusinessCreatePage(categoryId: categoryId),
                      );
                    },
                  ),
                  GoRoute(
                    path: ':businessId',
                    name: 'businessDetails',
                    builder: (context, state) {
                      final businessId = state.pathParameters['businessId']!;
                      return BlocProvider<BusinessDetailsCubit>(
                        create: (_) =>
                            getIt<BusinessDetailsCubit>()..load(businessId),
                        child: BusinessDetailsPage(businessId: businessId),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: AppRoutes.jobs,
                name: 'jobs',
                builder: (context, state) {
                  return BlocProvider<JobsCubit>(
                    create: (_) => getIt<JobsCubit>()..load(),
                    child: const JobsPage(),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'vacancies/:jobId',
                    name: 'jobVacancyDetails',
                    builder: (context, state) {
                      final jobId = state.pathParameters['jobId']!;
                      return BlocProvider<JobDetailsCubit>(
                        create: (_) =>
                            getIt<JobDetailsCubit>()..loadVacancy(jobId),
                        child: JobDetailsPage(vacancyId: jobId),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'candidates/:candidateId',
                    name: 'jobCandidateDetails',
                    builder: (context, state) {
                      final candidateId = state.pathParameters['candidateId']!;
                      return BlocProvider<JobDetailsCubit>(
                        create: (_) =>
                            getIt<JobDetailsCubit>()
                              ..loadCandidate(candidateId),
                        child: CandidateDetailsPage(candidateId: candidateId),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'create',
                    name: 'jobCreate',
                    builder: (context, state) {
                      final tabName = state.uri.queryParameters['tab'];
                      final tab = JobsTab.values.firstWhere(
                        (value) => value.name == tabName,
                        orElse: () => JobsTab.vacancies,
                      );
                      return BlocProvider<JobsCubit>(
                        create: (_) => getIt<JobsCubit>()..load(),
                        child: JobCreatePage(tab: tab),
                      );
                    },
                  ),
                ],
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
