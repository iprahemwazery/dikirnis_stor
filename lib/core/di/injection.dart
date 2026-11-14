import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../features/categories/data/datasources/categories_data_source.dart';
import '../../features/categories/data/datasources/mock_categories_data_source.dart';
import '../../features/categories/data/repositories/categories_repository_impl.dart';
import '../../features/categories/domain/repositories/categories_repository.dart';
import '../../features/categories/presentation/cubit/categories_cubit.dart';
import '../../features/home/data/datasources/home_data_source.dart';
import '../../features/home/data/datasources/home_preview_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/offers/data/datasources/offers_data_source.dart';
import '../../features/offers/data/datasources/offers_preview_data_source.dart';
import '../../features/offers/data/repositories/in_memory_offer_favorites_repository.dart';
import '../../features/offers/data/repositories/offers_repository_impl.dart';
import '../../features/offers/domain/repositories/offer_favorites_repository.dart';
import '../../features/offers/domain/repositories/offers_repository.dart';
import '../../features/offers/presentation/cubit/offer_details_cubit.dart';
import '../../features/offers/presentation/cubit/offers_cubit.dart';
import '../../features/profile/data/datasources/profile_data_source.dart';
import '../../features/profile/data/datasources/profile_preview_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../config/app_config.dart';
import '../network/api_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (getIt.isRegistered<Dio>()) {
    return;
  }

  getIt
    ..registerLazySingleton<Dio>(_createDio)
    ..registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()))
    ..registerLazySingleton<CategoriesDataSource>(MockCategoriesDataSource.new)
    ..registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(getIt<CategoriesDataSource>()),
    )
    ..registerFactory<CategoriesCubit>(
      () => CategoriesCubit(getIt<CategoriesRepository>()),
    )
    ..registerLazySingleton<HomeDataSource>(HomePreviewDataSource.new)
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(getIt<HomeDataSource>()),
    )
    ..registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()))
    ..registerLazySingleton<ProfileDataSource>(ProfilePreviewDataSource.new)
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(getIt<ProfileDataSource>()),
    )
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(getIt<ProfileRepository>()),
    )
    ..registerLazySingleton<OffersDataSource>(OffersPreviewDataSource.new)
    ..registerLazySingleton<OffersRepository>(
      () => OffersRepositoryImpl(getIt<OffersDataSource>()),
    )
    ..registerLazySingleton<OfferFavoritesRepository>(
      InMemoryOfferFavoritesRepository.new,
    )
    ..registerFactory<OffersCubit>(
      () => OffersCubit(
        getIt<OffersRepository>(),
        getIt<OfferFavoritesRepository>(),
      ),
    )
    ..registerFactory<OfferDetailsCubit>(
      () => OfferDetailsCubit(
        getIt<OffersRepository>(),
        getIt<OfferFavoritesRepository>(),
      ),
    );
}

Dio _createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: AppConfig.connectTimeout,
      sendTimeout: AppConfig.sendTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      headers: const {'Accept': 'application/json'},
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }

  return dio;
}
