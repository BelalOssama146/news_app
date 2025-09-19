import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String selectedLanguage = "en";

  LanguageProvider() {
    getLanguage(); // يحمل اللغة اول ما يتبني
  }

  Future<void> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? myLanguage = prefs.getString('language');
    if (myLanguage != null) {
      selectedLanguage = myLanguage;
      notifyListeners();
    }
  }

  set appLanguage(String newLanguage) {
    selectedLanguage = newLanguage;
    saveLanguage(newLanguage);
    notifyListeners();
  }

  Future<void> saveLanguage(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", lang);
  }
}

// class LanguageProvider extends ChangeNotifier{
//   String selectedLanguage = "en";
//
//   LanguageProvider(){
//     getLanguage();
//   }
//
//   Future<void> getLanguage() async{
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? myLanguage = prefs.getString('language');
//     if(myLanguage != null){
//       selectedLanguage = myLanguage;
//       notifyListeners();
//     }
//
//   }
//   set appLanguage(String newLanguage) {
//     selectedLanguage = newLanguage;
//      SharedPreferences.getInstance().then((prefs){
//       prefs.setString("language",selectedLanguage);
//     });
//     notifyListeners();
//   }
// }