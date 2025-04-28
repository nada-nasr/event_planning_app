import 'package:flutter/material.dart';

import '../utils/shared_prefs_theming.dart';

class ThemeProvider extends ChangeNotifier {
  // data
  static const String themingKey = 'theming_key';
  ThemeMode currentTheme = ThemeMode.light;

  // function
  void loadTheme() {
    ///getThemeMode();
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) {
      return;
    }
    currentTheme = newTheme;
    notifyListeners();

    ///setThemeMode(newTheme);
  }

  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }
}
