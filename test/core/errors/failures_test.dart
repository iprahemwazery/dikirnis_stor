import 'package:dikirnis_stor/core/errors/app_exception.dart';
import 'package:dikirnis_stor/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps known exceptions to failure types', () {
    expect(
      AppFailure.fromException(const NetworkException()).type,
      FailureType.network,
    );
    expect(
      AppFailure.fromException(const RequestTimeoutException()).type,
      FailureType.timeout,
    );
    expect(
      AppFailure.fromException(const ValidationException()).type,
      FailureType.validation,
    );
    expect(
      AppFailure.fromException(const UnauthorizedException()).type,
      FailureType.unauthorized,
    );
    expect(
      AppFailure.fromException(const ForbiddenException()).type,
      FailureType.forbidden,
    );
    expect(
      AppFailure.fromException(const ServerException()).type,
      FailureType.server,
    );
    expect(
      AppFailure.fromException(const NotFoundException()).type,
      FailureType.notFound,
    );
    expect(
      AppFailure.fromException(const ConflictException()).type,
      FailureType.conflict,
    );
    expect(
      AppFailure.fromException(const RateLimitException()).type,
      FailureType.rateLimited,
    );
    expect(
      AppFailure.fromException(const ParsingException()).type,
      FailureType.parsing,
    );
  });

  test('preserves HTTP status and retry metadata', () {
    final failure = AppFailure.fromException(
      const RateLimitException(
        statusCode: 429,
        retryAfter: Duration(seconds: 30),
      ),
    );

    expect(failure.statusCode, 429);
    expect(failure.retryAfter, const Duration(seconds: 30));
    expect(failure.isRetryable, isTrue);
  });

  test('marks cancellation separately from failures', () {
    final failure = AppFailure.fromException(const RequestCancelledException());

    expect(failure.type, FailureType.cancelled);
    expect(failure.isCancellation, isTrue);
    expect(failure.isRetryable, isFalse);
  });

  test('falls back to unknown for non-application errors', () {
    final failure = AppFailure.fromException(StateError('unexpected'));

    expect(failure.type, FailureType.unknown);
    expect(failure.message, isNull);
  });
}
