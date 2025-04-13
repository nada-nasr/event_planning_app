import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  // data
  String currentLocal = 'en';

  // function
  void changeLanguage(String newLocal) {
    if (currentLocal == newLocal) {
      return;
    }
    currentLocal = newLocal;
    notifyListeners();
  }
}
