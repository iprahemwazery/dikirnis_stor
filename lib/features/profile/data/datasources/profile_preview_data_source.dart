import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../core/errors/app_exception.dart';
import '../models/profile_model.dart';
import 'profile_data_source.dart';

class ProfilePreviewDataSource implements ProfileDataSource {
  ProfilePreviewDataSource({
    AssetBundle? bundle,
    this.delay = const Duration(milliseconds: 350),
  }) : _bundle = bundle ?? rootBundle;

  static const String assetPath = 'assets/data/profile_preview.json';

  final AssetBundle _bundle;
  final Duration delay;

  @override
  Future<ProfileModel> fetchProfile() async {
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }

    try {
      final raw = await _bundle.loadString(assetPath);
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        throw const ParsingException(
          message: 'The profile preview data is not a JSON object.',
        );
      }
      return ProfileModel.fromJson(decoded);
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
