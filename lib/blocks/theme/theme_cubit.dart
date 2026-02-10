import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/settings_repository/settings_repository.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required SettingsRepositoryInterface settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const ThemeState(Brightness.light)) {
    _checkThemeState();
  }

  final SettingsRepositoryInterface _settingsRepository;

  Future<void> _checkThemeState() async {
    try {
      final isDark = await _settingsRepository.isDarkThemeSelected();
      emit(ThemeState(isDark ? Brightness.dark : Brightness.light));
    } catch (e) {
      print('Ошибка загрузки темы: $e');
      // fallback
      emit(const ThemeState(Brightness.light));
    }
  }

  Future<void> changeTheme(Brightness brightness) async {
    emit(ThemeState(brightness));
    await _settingsRepository.setDarkThemeState(brightness == Brightness.dark);
  }

  Future<void> toggleTheme() async {
    final next = state.brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;
    await changeTheme(next);
  }
}
