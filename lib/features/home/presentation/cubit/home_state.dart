import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/business.dart';
import '../../domain/entities/home_advertisement.dart';
import '../../domain/entities/home_banner.dart';
import '../../domain/entities/home_category.dart';
import '../../domain/entities/home_content.dart';

enum HomeStatus { initial, loading, success, empty, failure }

const Object _unset = Object();

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.content,
    this.failure,
    this.searchQuery = '',
    this.advertisementDismissed = false,
  });

  final HomeStatus status;
  final HomeContent? content;
  final AppFailure? failure;
  final String searchQuery;
  final bool advertisementDismissed;

  List<HomeBanner> get banners => content?.banners ?? const [];
  List<HomeCategory> get categories => content?.categories ?? const [];
  List<Business> get mostViewed => content?.mostViewed ?? const [];
  List<Business> get recentlyAdded => content?.recentlyAdded ?? const [];
  List<Business> get medical => content?.medical ?? const [];
  List<Business> get restaurants => content?.restaurants ?? const [];
  HomeAdvertisement? get advertisement =>
      advertisementDismissed ? null : content?.advertisement;

  HomeState copyWith({
    HomeStatus? status,
    Object? content = _unset,
    Object? failure = _unset,
    String? searchQuery,
    bool? advertisementDismissed,
  }) {
    return HomeState(
      status: status ?? this.status,
      content: identical(content, _unset)
          ? this.content
          : content as HomeContent?,
      failure: identical(failure, _unset)
          ? this.failure
          : failure as AppFailure?,
      searchQuery: searchQuery ?? this.searchQuery,
      advertisementDismissed:
          advertisementDismissed ?? this.advertisementDismissed,
    );
  }

  @override
  List<Object?> get props => [
    status,
    content,
    failure,
    searchQuery,
    advertisementDismissed,
  ];
}
