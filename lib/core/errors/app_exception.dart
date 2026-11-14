sealed class AppException implements Exception {
  const AppException({this.message, this.cause});

  final String? message;
  final Object? cause;

  @override
  String toString() => message ?? runtimeType.toString();
}

final class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection.',
    super.cause,
  });
}

final class RequestTimeoutException extends AppException {
  const RequestTimeoutException({
    super.message = 'The request timed out.',
    super.cause,
  });
}

final class ServerException extends AppException {
  const ServerException({
    this.statusCode,
    super.message = 'The server returned an error.',
    super.cause,
  });

  final int? statusCode;
}

final class ValidationException extends AppException {
  const ValidationException({
    this.statusCode = 400,
    super.message = 'The request could not be processed.',
    super.cause,
  });

  final int statusCode;
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException({
    this.statusCode = 401,
    super.message = 'Authentication is required.',
    super.cause,
  });

  final int statusCode;
}

final class ForbiddenException extends AppException {
  const ForbiddenException({
    this.statusCode = 403,
    super.message = 'You do not have permission to do that.',
    super.cause,
  });

  final int statusCode;
}

final class NotFoundException extends AppException {
  const NotFoundException({
    this.statusCode = 404,
    super.message = 'The requested resource was not found.',
    super.cause,
  });

  final int statusCode;
}

final class ConflictException extends AppException {
  const ConflictException({
    this.statusCode = 409,
    super.message = 'The resource changed. Please try again.',
    super.cause,
  });

  final int statusCode;
}

final class RateLimitException extends AppException {
  const RateLimitException({
    this.statusCode = 429,
    this.retryAfter,
    super.message = 'Too many requests. Please try again later.',
    super.cause,
  });

  final int statusCode;
  final Duration? retryAfter;
}

final class RequestCancelledException extends AppException {
  const RequestCancelledException({
    super.message = 'The request was cancelled.',
    super.cause,
  });
}

final class ParsingException extends AppException {
  const ParsingException({
    super.message = 'The response could not be parsed.',
    super.cause,
  });
}

final class UnknownException extends AppException {
  const UnknownException({
    super.message = 'An unexpected error occurred.',
    super.cause,
  });
}
