import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/tabs/categories/app_category.dart';
import 'package:news_app/ui/utils/app_style.dart';
import '../../../../data/model/category.dart';

class CategoriesTab extends StatefulWidget {
  static const String routeName = "category_tab";
  final void Function(Category) onCategory;
  const CategoriesTab(this.onCategory,{super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 36, top: 35),
          child: Container(
            width: MediaQuery.of(context).size.width*0.49,
              child: Text("Pick your category of interest",style: AppStyle.titleText,)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
                itemCount: Category.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 20
                ),
                itemBuilder: (context,index) =>
                    InkWell(
                      onTap: (){
                        widget.onCategory(Category.categories[index]);
                        setState(() {});
                      },
                     child: AppCategory(category: Category.categories[index]))
            ),
          ),
        )]
    );
  }
}
