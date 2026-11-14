abstract final class AppConfig {
  static const String appName = 'Dikirnis Store';

  /// Supplied at build time, for example:
  /// `flutter run --dart-define=API_BASE_URL=https://api.example.com/v1`
  ///
  /// An empty value means no backend has been configured yet.
  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 20);

  static bool get hasBackend => apiBaseUrl.trim().isNotEmpty;
}
