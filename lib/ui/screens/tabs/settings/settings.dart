import 'package:flutter/material.dart';
import 'package:news_app/ui/extension/build_context_extension.dart';
import 'package:news_app/ui/providers/language_provider.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:news_app/ui/utils/app_style.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  static const String routeName = "settings";
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late LanguageProvider languageProvider;
  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 26, left: 30),
          child: Text(
              context.locale.language, style: AppStyle.languageTextStyle),
        ),
        SizedBox(height: 18,),
        Padding(
          padding: const EdgeInsets.only(left: 46, right: 46),
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 20),
            decoration: BoxDecoration(
              border: BoxBorder.all(color: AppColors.appBarColor),
                color: AppColors.white,
            ),
            child: DropdownButton(
              isExpanded: true,
              value: languageProvider.selectedLanguage,
              items: [
                DropdownMenuItem(value: "en",
                    child: Text(
                      "English", style: AppStyle.sourceTitleTextStyle,)),
                DropdownMenuItem(value: "ar",
                    child: Text(
                      "العربية", style: AppStyle.sourceTitleTextStyle,))
                ],
              onChanged: (newValue) {
                languageProvider.appLanguage =
                    newValue ?? languageProvider.selectedLanguage;
                setState(() {});
              },
            ),
          ),
        )
      ],
    );
  }
}

