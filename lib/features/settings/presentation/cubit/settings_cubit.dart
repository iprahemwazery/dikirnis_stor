import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsCubit extends Cubit<AppSettings> {
  SettingsCubit(this._repository) : super(_repository.read());

  final SettingsRepository _repository;

  Future<void> setLanguage(AppLanguage language) async {
    if (language == state.language) {
      return;
    }
    await _persist(state.copyWith(language: language));
  }

  Future<void> setTheme(AppThemePreference theme) async {
    if (theme == state.theme) {
      return;
    }
    await _persist(state.copyWith(theme: theme));
  }

  Future<void> _persist(AppSettings next) async {
    final previous = state;
    emit(next);
    try {
      await _repository.write(next);
    } catch (_) {
      if (!isClosed) {
        emit(previous);
      }
      rethrow;
    }
  }
}
