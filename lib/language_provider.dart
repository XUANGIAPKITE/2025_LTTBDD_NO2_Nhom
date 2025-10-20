import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _language = 'en'; // mặc định là English

  String get language => _language;

  void toggleLanguage() {
    _language = _language == 'en' ? 'vi' : 'en';
    notifyListeners();
  }

  void setLanguage(String langCode) {
    _language = langCode;
    notifyListeners();
  }
}
