import 'package:flutter/material.dart';
import '../utils/utils.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _sharedPrefHelper = SharedPreferenceHelper();
  }
  // shared pref object
  late SharedPreferenceHelper _sharedPrefHelper;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get getThemeMode {
    _sharedPrefHelper.getThemeMode.then((statusValue) {
      _themeMode = statusValue;
    });
    return _themeMode;
  }

  void updateThemeMode(ThemeMode themeMode) {
    _sharedPrefHelper.changeThemeMode(themeMode);
    _sharedPrefHelper.getThemeMode.then((themeModeStatus) {
      _themeMode = themeModeStatus;
    });
    notifyListeners();
  }
}
