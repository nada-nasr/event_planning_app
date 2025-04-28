/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsKeys{
  static const String themingKey = 'theming_key';
}
void setThemeMode(ThemeMode themeMode) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String themeString;
  if(themeMode == ThemeMode.light){
    themeString = 'light';
  }else {
    themeString = 'dark';
  }
  await prefs.setString(PrefsKeys.themingKey, themeString);
}

Future<ThemeMode> getThemeMode() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? theme = prefs.getString(PrefsKeys.themingKey);
  if(theme == 'light'){
    return ThemeMode.light;
  }else {
    return ThemeMode.dark;
  }
}*/
