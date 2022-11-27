import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  SharedPreferenceHelper() {
    _pref = SharedPreferences.getInstance();
  }
  late Future<SharedPreferences> _pref;
  static const String themeMode = 'theme_mode';

  //Theme module
  Future<bool> changeThemeMode(ThemeMode value) async {
    final pref = await _pref;
    return pref.setString(themeMode, value.name);
  }

  Future<ThemeMode> get getThemeMode async {
    final pref = await _pref;
    final value = pref.getString(themeMode) ?? ThemeMode.system.name;
    switch (value) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
