import 'package:flutter/foundation.dart';

import 'app_exception.dart';

enum FailureType {
  network,
  timeout,
  validation,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  rateLimited,
  server,
  cancelled,
  parsing,
  unknown,
}

@immutable
class AppFailure {
  const AppFailure(this.type, {this.message, this.statusCode, this.retryAfter});

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
      ValidationException(:final message, :final statusCode) => AppFailure(
        FailureType.validation,
        message: message,
        statusCode: statusCode,
      ),
      UnauthorizedException(:final message, :final statusCode) => AppFailure(
        FailureType.unauthorized,
        message: message,
        statusCode: statusCode,
      ),
      ForbiddenException(:final message, :final statusCode) => AppFailure(
        FailureType.forbidden,
        message: message,
        statusCode: statusCode,
      ),
      NotFoundException(:final message, :final statusCode) => AppFailure(
        FailureType.notFound,
        message: message,
        statusCode: statusCode,
      ),
      ConflictException(:final message, :final statusCode) => AppFailure(
        FailureType.conflict,
        message: message,
        statusCode: statusCode,
      ),
      RateLimitException(
        :final message,
        :final statusCode,
        :final retryAfter,
      ) =>
        AppFailure(
          FailureType.rateLimited,
          message: message,
          statusCode: statusCode,
          retryAfter: retryAfter,
        ),
      ServerException(:final message, :final statusCode) => AppFailure(
        FailureType.server,
        message: message,
        statusCode: statusCode,
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
  final int? statusCode;
  final Duration? retryAfter;

  bool get isRetryable {
    return switch (type) {
      FailureType.network ||
      FailureType.timeout ||
      FailureType.rateLimited ||
      FailureType.server => true,
      _ => false,
    };
  }

  bool get isCancellation => type == FailureType.cancelled;
}
