import 'package:flutter/material.dart';
import 'package:news_app/ui/utils/app_colors.dart';
abstract class AppStyle{
  static const appBarTextStyle = TextStyle(fontSize: 26,color: AppColors.white, fontWeight: FontWeight.bold);
  static const drawerStyle = TextStyle(fontSize: 24,color: AppColors.black, fontWeight: FontWeight.bold);
  static const titleText = TextStyle(fontSize: 22,color: AppColors.black, fontWeight: FontWeight.bold);
  static const languageTextStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:AppColors.black);
  static const sourceTitleTextStyle = TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color:AppColors.appBarColor );
  static const titleNews = TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color:AppColors.grey);
  static const dateNews = TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color:AppColors.grey);


}