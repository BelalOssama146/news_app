import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  String selectedLanguage = "en";

  set appLanguage(String newLanguage) {
    selectedLanguage = newLanguage;
    notifyListeners();
  }
}