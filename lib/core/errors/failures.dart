import 'package:flutter/foundation.dart';

import 'app_exception.dart';

enum FailureType {
  network,
  timeout,
  server,
  notFound,
  cancelled,
  parsing,
  unknown,
}

@immutable
class AppFailure {
  const AppFailure(this.type, {this.message});

  factory AppFailure.fromException(Object error) {
    return switch (error) {
      NetworkException(:final message) => AppFailure(
        FailureType.network,
        message: message,
      ),
      RequestTimeoutException(:final message) => AppFailure(
        FailureType.timeout,
        message: message,
      ),
      ServerException(:final message) => AppFailure(
        FailureType.server,
        message: message,
      ),
      NotFoundException(:final message) => AppFailure(
        FailureType.notFound,
        message: message,
      ),
      RequestCancelledException(:final message) => AppFailure(
        FailureType.cancelled,
        message: message,
      ),
      ParsingException(:final message) => AppFailure(
        FailureType.parsing,
        message: message,
      ),
      AppException(:final message) => AppFailure(
        FailureType.unknown,
        message: message,
      ),
      _ => const AppFailure(FailureType.unknown),
    };
  }

  final FailureType type;
  final String? message;
}
