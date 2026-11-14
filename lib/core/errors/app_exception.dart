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

final class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'The requested resource was not found.',
    super.cause,
  });
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
