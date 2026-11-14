import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../core/errors/app_exception.dart';
import '../models/offers_content_model.dart';
import 'offers_data_source.dart';

class OffersPreviewDataSource implements OffersDataSource {
  OffersPreviewDataSource({
    AssetBundle? bundle,
    this.delay = const Duration(milliseconds: 350),
  }) : _bundle = bundle ?? rootBundle;

  static const String assetPath = 'assets/data/offers_preview.json';

  final AssetBundle _bundle;
  final Duration delay;

  @override
  Future<OffersContentModel> fetchOffersCatalog() async {
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }

    try {
      final raw = await _bundle.loadString(assetPath);
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw const ParsingException(
          message: 'The offers preview data is not a JSON object.',
        );
      }
      return OffersContentModel.fromJson(decoded);
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
