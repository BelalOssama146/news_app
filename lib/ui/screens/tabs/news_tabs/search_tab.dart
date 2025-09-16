import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/model/articles_response.dart';
import 'package:news_app/ui/screens/tabs/news_tabs/news_details.dart';
import 'package:news_app/ui/widget/loading_view.dart';
import '../../../../data/model/article.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_style.dart';

class SearchTab extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
     IconButton(onPressed: (){
       showResults(context);
     }, icon: Icon(Icons.search))
   ];
  }

  Widget getResults(){
    return FutureBuilder(
        future: ApiManager.getArticles(query: query),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return LoadingView();
          }
          ArticlesResponse result = snapshot.data as ArticlesResponse;
          if(result.articles!.isEmpty){
            return Center(child: Text("No results found"));
          }
          return ListView.builder(
            itemCount: result.articles?.length,
            itemBuilder: (context, index) =>  mapSourceToWidget(context,result.articles![index]),);
        }
    );
  }
  Widget mapSourceToWidget(BuildContext context,Article article) {
    return Padding(
      padding: const EdgeInsets.only(left: 26,right: 26),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, NewsDetails.routeName,arguments: article);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Image.network(article.urlToImage??""),
            Text(article.source?.name??"",style: AppStyle.titleNews,),
            Text(article.title??"",style: AppStyle.sourceTitleTextStyle.copyWith(color: AppColors.black),),
            Align(
                alignment: AlignmentGeometry.centerRight,
                child: Text(article.publishedAt??"",style: AppStyle.dateNews,))
          ],
        ),
      ),
    );
  }
  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon:Icon(Icons.arrow_back));

  }

  @override
  Widget buildResults(BuildContext context) {
    return getResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return getResults();
  }
  @override
  ThemeData appBarTheme(BuildContext context) {

    return ThemeData(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppColors.white),
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.vertical(bottom: Radius.circular(50))),
          actionsIconTheme: IconThemeData(color: AppColors.white,size: 30),
          iconTheme: IconThemeData(color: AppColors.white),

      )
    );
  }

}