import 'dart:typed_data';

import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/core/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.statusCode, {this.headers = const {}});

  final int statusCode;
  final Map<String, List<String>> headers;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      '{}',
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        ...headers,
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

ApiClient _clientFor(
  int statusCode, {
  Map<String, List<String>> headers = const {},
}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
    ..httpClientAdapter = _StubAdapter(statusCode, headers: headers);
  return ApiClient(dio);
}

void main() {
  test('maps validation and authentication status codes', () async {
    await expectLater(
      _clientFor(400).get<void>('/resource'),
      throwsA(
        isA<ValidationException>().having(
          (error) => error.statusCode,
          'statusCode',
          400,
        ),
      ),
    );
    await expectLater(
      _clientFor(422).get<void>('/resource'),
      throwsA(isA<ValidationException>()),
    );
    await expectLater(
      _clientFor(401).get<void>('/resource'),
      throwsA(isA<UnauthorizedException>()),
    );
    await expectLater(
      _clientFor(403).get<void>('/resource'),
      throwsA(isA<ForbiddenException>()),
    );
  });

  test('maps resource, conflict, timeout, and server status codes', () async {
    await expectLater(
      _clientFor(404).get<void>('/resource'),
      throwsA(isA<NotFoundException>()),
    );
    await expectLater(
      _clientFor(408).get<void>('/resource'),
      throwsA(isA<RequestTimeoutException>()),
    );
    await expectLater(
      _clientFor(409).get<void>('/resource'),
      throwsA(isA<ConflictException>()),
    );
    await expectLater(
      _clientFor(503).get<void>('/resource'),
      throwsA(
        isA<ServerException>().having(
          (error) => error.statusCode,
          'statusCode',
          503,
        ),
      ),
    );
  });

  test('maps rate limiting and preserves retry-after', () async {
    await expectLater(
      _clientFor(
        429,
        headers: {
          'retry-after': ['120'],
        },
      ).get<void>('/resource'),
      throwsA(
        isA<RateLimitException>()
            .having((error) => error.statusCode, 'statusCode', 429)
            .having(
              (error) => error.retryAfter,
              'retryAfter',
              const Duration(seconds: 120),
            ),
      ),
    );
  });
}
