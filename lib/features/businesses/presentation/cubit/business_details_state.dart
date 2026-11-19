import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/business.dart';

enum BusinessDetailsStatus { initial, loading, success, notFound, failure }

class BusinessDetailsState extends Equatable {
  const BusinessDetailsState({
    this.status = BusinessDetailsStatus.initial,
    this.business,
    this.failure,
  });

  final BusinessDetailsStatus status;
  final Business? business;
  final AppFailure? failure;

  BusinessDetailsState copyWith({
    BusinessDetailsStatus? status,
    Business? business,
    AppFailure? failure,
  }) {
    return BusinessDetailsState(
      status: status ?? this.status,
      business: business ?? this.business,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, business, failure];
}
