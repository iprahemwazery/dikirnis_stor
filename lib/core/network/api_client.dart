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
    final statusCode = error.response?.statusCode;
    if (statusCode == 404) {
      return NotFoundException(cause: error);
    }
    return ServerException(statusCode: statusCode, cause: error);
  }
}
