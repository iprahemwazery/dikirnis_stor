import 'package:dio/dio.dart';

import '../errors/app_exception.dart';

class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return _send(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return _send(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Response<T>> _send<T>(Future<Response<T>> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  AppException _mapDioException(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout => RequestTimeoutException(
        cause: error,
      ),
      DioExceptionType.connectionError => NetworkException(cause: error),
      DioExceptionType.badResponse => _mapBadResponse(error),
      DioExceptionType.cancel => RequestCancelledException(cause: error),
      DioExceptionType.badCertificate => const NetworkException(
        message: 'The server certificate is not valid.',
      ),
      DioExceptionType.unknown => UnknownException(cause: error.error ?? error),
    };
  }

  AppException _mapBadResponse(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    return switch (statusCode) {
      400 || 422 => ValidationException(statusCode: statusCode!, cause: error),
      401 => UnauthorizedException(cause: error),
      403 => ForbiddenException(cause: error),
      404 => NotFoundException(cause: error),
      408 => RequestTimeoutException(cause: error),
      409 => ConflictException(cause: error),
      429 => RateLimitException(
        retryAfter: _parseRetryAfter(response?.headers.value('retry-after')),
        cause: error,
      ),
      _ => ServerException(statusCode: statusCode, cause: error),
    };
  }

  Duration? _parseRetryAfter(String? value) {
    final seconds = int.tryParse(value?.trim() ?? '');
    if (seconds == null || seconds < 0) {
      return null;
    }
    return Duration(seconds: seconds);
  }
}
