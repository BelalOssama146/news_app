import 'package:flutter/material.dart';
import 'package:news_app/ui/extension/build_context_extension.dart';
import 'package:news_app/ui/utils/app_style.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/model/article.dart';
import '../../../utils/app_colors.dart';

class NewsDetails extends StatelessWidget {
  static const String routeName = "newsDetails";
  const NewsDetails({super.key});



  @override
  Widget build(BuildContext context) {
     Article article = ModalRoute.of(context)!.settings.arguments as Article;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/pattern.png"),fit: BoxFit.cover),
          color: AppColors.white
      ),
      child: Scaffold(
        backgroundColor:AppColors.transparent,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height*0.1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.vertical(bottom: Radius.circular(50))),
          backgroundColor: AppColors.appBarColor,
          title: Text(context.locale.title, style: AppStyle.appBarTextStyle,),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Image.network(article.urlToImage??""),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(article.source?.name??"",style: AppStyle.titleNews,),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(article.title??"",style: AppStyle.sourceTitleTextStyle.copyWith(color: AppColors.black),),
            ),
            Align(
                alignment: AlignmentGeometry.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(formatTimeAgo(article.publishedAt??""),style: AppStyle.dateNews,),
                )
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: MediaQuery.of(context).size.height*0.37,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(25),
                ),
                  child: Column(
                    children: [
                      Text(article.content??"",
                        style: AppStyle.sourceTitleTextStyle.copyWith(color: AppColors.black),), SizedBox(height: 20,),
                      SizedBox(height: 55,),
                      InkWell(
                        onTap: (){
                          _launchUrl(article.url??"");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(context.locale.view, style: AppStyle
                                .sourceTitleTextStyle.copyWith(
                                color: AppColors.black),),
                            SizedBox(width: 5,),
                            Icon(Icons.arrow_forward,size: 20,)
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ),
          ],
        ),
      )
    );
  }
  String formatTimeAgo(String date){
    DateTime dateTime = DateTime.parse(date);
    return timeago.format(dateTime);
  }
  Future<void> _launchUrl(String url) async {
    Uri launcher = Uri.parse(url);
    if (!await launchUrl(launcher)) {
      throw Exception('Could not launch $launcher');
    }
}
}
