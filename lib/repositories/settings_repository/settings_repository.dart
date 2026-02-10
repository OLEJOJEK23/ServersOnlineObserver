import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepositoryInterface {
  Future<bool> isDarkThemeSelected();

  Future<void> setDarkThemeState(bool isDark);
}

class SettingsRepository implements SettingsRepositoryInterface {
  static const String _darkThemeKey = 'is_dark_theme';

  @override
  Future<bool> isDarkThemeSelected() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkThemeKey) ?? false;
  }

  @override
  Future<void> setDarkThemeState(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkThemeKey, isDark);
  }
}
