import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../core/errors/app_exception.dart';
import '../models/home_content_model.dart';
import 'home_data_source.dart';

class HomePreviewDataSource implements HomeDataSource {
  HomePreviewDataSource({
    AssetBundle? bundle,
    this.delay = const Duration(milliseconds: 400),
  }) : _bundle = bundle ?? rootBundle;

  static const String assetPath = 'assets/data/home_preview.json';

  final AssetBundle _bundle;
  final Duration delay;

  @override
  Future<HomeContentModel> fetchHomeContent() async {
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }

    try {
      final raw = await _bundle.loadString(assetPath);
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw const ParsingException(
          message: 'The home preview data is not a JSON object.',
        );
      }
      return HomeContentModel.fromJson(decoded);
    } on AppException {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      Error.throwWithStackTrace(ParsingException(cause: error), stackTrace);
    } on TypeError catch (error, stackTrace) {
      Error.throwWithStackTrace(ParsingException(cause: error), stackTrace);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UnknownException(cause: error), stackTrace);
    }
  }
}
