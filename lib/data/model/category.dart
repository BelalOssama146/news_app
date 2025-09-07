import 'package:flutter/material.dart';
class Category {
  String backEndId;
  String title;
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
    Category(backEndId: "sports", title: "Sports", imagePath: "assets/ball.png",
        isLeftSided: true, backgroundColor: Color(0xffC91C22)),
    Category(backEndId: "technology", title: "Technology", imagePath: "assets/Politics.png", 
        isLeftSided: false, backgroundColor: Color(0xff003E90)),
    Category(backEndId: "health", title: "Health", imagePath: "assets/health.png",
        isLeftSided: true, backgroundColor: Color(0xffED1E79)),
    Category(backEndId: "business", title: "Business", imagePath: "assets/bussines.png",
        isLeftSided: false, backgroundColor: Color(0xffCF7E48)),
    Category(backEndId: "entertainment", title: "Entertainment", imagePath: "assets/environment.png",
        isLeftSided: true, backgroundColor: Color(0xff4882CF)),
    Category(backEndId: "science", title: "Science", imagePath: "assets/science.png",
        isLeftSided: false, backgroundColor: Color(0xffF2D352)),
  ];

}