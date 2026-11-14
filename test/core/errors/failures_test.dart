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
      AppFailure.fromException(const ServerException()).type,
      FailureType.server,
    );
    expect(
      AppFailure.fromException(const NotFoundException()).type,
      FailureType.notFound,
    );
    expect(
      AppFailure.fromException(const ParsingException()).type,
      FailureType.parsing,
    );
  });

  test('falls back to unknown for non-application errors', () {
    final failure = AppFailure.fromException(StateError('unexpected'));

    expect(failure.type, FailureType.unknown);
    expect(failure.message, isNull);
  });
}
