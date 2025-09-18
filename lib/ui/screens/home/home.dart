import 'package:flutter/material.dart';
import 'package:news_app/data/model/category.dart';
import 'package:news_app/ui/extension/build_context_extension.dart';
import 'package:news_app/ui/providers/language_provider.dart';
import 'package:news_app/ui/screens/tabs/categories/categories_tab.dart';
import 'package:news_app/ui/screens/tabs/news_tabs/search_tab.dart';
import 'package:news_app/ui/screens/tabs/settings/settings.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:news_app/ui/utils/app_style.dart';
import 'package:provider/provider.dart';
import '../tabs/news_tabs/tab_list.dart';

class Home extends StatefulWidget {
  static const String routeName = "Home";
   const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late LanguageProvider languageProvider;
  late Widget currentTab;
  int selectedIndex = 0;
  String appBarTitle = "News App";
  @override
  void initState() {
    super.initState();
    currentTab = CategoriesTab(onCategoryClick);
  }

  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/pattern.png"),fit: BoxFit.cover),
      color: AppColors.white
    ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: buildAppBar(),
        drawer: buildDrawer(),
        body: currentTab,
      ),
    );
  }
  void onCategoryClick(Category category){
    switchTab(
        TabList(categoryId: category.backEndId),
        category.title(context));
    setState(() {});
  }

  void switchTab(Widget tab, String titleKey) {
    currentTab = tab;
    appBarTitle = titleKey;
    setState(() {});
  }
  AppBar buildAppBar(){
    return AppBar(
      iconTheme: IconThemeData(
          color: AppColors.white,
          size: 30
      ),
      toolbarHeight: MediaQuery.of(context).size.height*0.1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.vertical(bottom: Radius.circular(50))),
      backgroundColor: AppColors.appBarColor,
      title: Text(context.locale.getString(appBarTitle),
        style: AppStyle.appBarTextStyle,),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: (){
              showSearch(context: context, delegate: SearchTab());
            },
            icon: Icon(Icons.search),
        ),
      ],
    );
  }
  Widget buildDrawer() => Drawer(
    backgroundColor: AppColors.white,
    child: SafeArea(
      child: Column(
        children: [
          buildDrawerHeader(),
          buildDrawerRow(
              iconData:Icons.list,
              title: context.locale.categories,
             onClick: (){
                switchTab(
                    CategoriesTab(onCategoryClick),
                    context.locale.news
                );
                Navigator.pop(context);
                setState(() {});
             }
          ),
          buildDrawerRow(
              iconData:Icons.settings,
              title: context.locale.getString("Settings"),
              onClick: (){
                switchTab(
                  Settings(),
                  "Settings",
                );
                Navigator.pop(context);
                setState(() {});
              }
          ),
        ],
      ),
    ),

  );
  Widget buildDrawerRow({required IconData iconData,required String title,required void Function() onClick}) =>
      InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(iconData,size: 28,),
              SizedBox(width: 8,),
              Text(title,style: AppStyle.drawerStyle,),
            ],
          ),
        ),
      );
  Container buildDrawerHeader() =>
      Container(
    height: MediaQuery.of(context).size.height*0.15,
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.appBarColor,
    ),
        child: Center(
            child: Text(context.locale.news, style: AppStyle.appBarTextStyle,)),
  );
}
