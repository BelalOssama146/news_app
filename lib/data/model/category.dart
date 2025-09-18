import 'package:flutter/material.dart';
import 'package:news_app/ui/extension/build_context_extension.dart';
class Category {
  String backEndId;
  String Function(BuildContext context) title;
  String imagePath;
  bool isLeftSided;
  Color backgroundColor;

  Category({
    required this.backEndId,
    required this.title,
    required this.imagePath,
    required this.isLeftSided,
    required this.backgroundColor
  });
  
  static List<Category> categories = [
    Category(backEndId: "sports",
        title: (context) => context.locale.sports,
        imagePath: "assets/ball.png",
        isLeftSided: true, backgroundColor: Color(0xffC91C22)),
    Category(backEndId: "technology",
        title: (context) => context.locale.technology,
        imagePath: "assets/Politics.png",
        isLeftSided: false, backgroundColor: Color(0xff003E90)),
    Category(backEndId: "health",
        title: (context) => context.locale.health,
        imagePath: "assets/health.png",
        isLeftSided: true, backgroundColor: Color(0xffED1E79)),
    Category(backEndId: "business",
        title: (context) => context.locale.business,
        imagePath: "assets/bussines.png",
        isLeftSided: false, backgroundColor: Color(0xffCF7E48)),
    Category(backEndId: "entertainment",
        title: (context) => context.locale.entertainment,
        imagePath: "assets/environment.png",
        isLeftSided: true, backgroundColor: Color(0xff4882CF)),
    Category(backEndId: "science",
        title: (context) => context.locale.science,
        imagePath: "assets/science.png",
        isLeftSided: false, backgroundColor: Color(0xffF2D352)),
  ];

}