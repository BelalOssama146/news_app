import 'package:flutter/material.dart';
import 'package:news_app/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get locale {
    return AppLocalizations.of(this)!;
  }
}

extension AppLocalizationExtension on AppLocalizations {
  String getString(String key) {
    switch (key) {
      case "Sports":
        return sports;
      case "Technology":
        return technology;
      case "Health":
        return health;
      case "Business":
        return business;
      case "Entertainment":
        return entertainment;
      case "Science":
        return science;
      case "Settings":
        return settings;
      case "News App":
        return news;
      default:
        return key;
    }
  }
}
