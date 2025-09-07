import 'package:flutter/material.dart';
import 'package:news_app/data/model/category.dart';
import 'package:news_app/ui/utils/app_style.dart';

class AppCategory extends StatelessWidget {
  final Category category;
  const AppCategory({super.key,required this.category});
  final radius = const Radius.circular(25);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(),
      decoration: BoxDecoration(
        color: category.backgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: radius,
            topRight: radius,
            bottomRight: category.isLeftSided ? Radius.zero : radius,
            bottomLeft: category.isLeftSided ? radius : Radius.zero
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(category.imagePath ,height: MediaQuery.of(context).size.height*0.15,),
          Text(category.title,style: AppStyle.titleText.copyWith(color: Colors.white),)
        ],
      ),
    );
    
  }
}
