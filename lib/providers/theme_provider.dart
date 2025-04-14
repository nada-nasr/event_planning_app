import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // data
  ThemeMode currentTheme = ThemeMode.light;

  // function
  void changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) {
      return;
    }
    currentTheme = newTheme;
    notifyListeners();
  }

  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }
}
