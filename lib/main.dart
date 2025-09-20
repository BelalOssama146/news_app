import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/data/hive_utils/hive_utils.dart';
import 'package:news_app/ui/providers/language_provider.dart';
import 'package:news_app/ui/screens/tabs/news_tabs/news_details.dart';
import 'package:provider/provider.dart';
import 'di.dart';
import 'l10n/app_localizations.dart';
import 'package:news_app/ui/screens/home/home.dart';
import 'package:news_app/ui/screens/splash/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  configureDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(SourceResponseAdapter());
  runApp(ChangeNotifierProvider(
    create: (_) => LanguageProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      locale: Locale(languageProvider.selectedLanguage),
      debugShowCheckedModeBanner: false,
      routes: {
        Home.routeName : (_) => Home(),
        Splash.routeName :(_) => Splash(),
        NewsDetails.routeName:(_) => NewsDetails()
      },
      initialRoute: Splash.routeName,
    );
  }
}

/// Http Requests:
/// Request type ( get - post - delete - etc...)
/// Get Requests (BaseUrl + ApiName + "?" + arguments)  no Body
/// Post Requests (BaseUrl + ApiName + "?" + arguments(optional))
/// Args are mostly placed in post request body
/// Headers() ignore for now
/// -------------------------------
/// Response:
/// Body -> html || json(java script object notaion) {key(String) : dynamic} || xml
/// Headers
/// status code(int) 40x -> clients error|| 50x -> server error || 20x -> successful