import 'package:flutter/material.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/data/model/source.dart';
import 'package:news_app/ui/screens/tabs/news_tabs/news_details.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:news_app/ui/utils/app_style.dart';
import 'package:news_app/ui/widget/error_view.dart';
import 'package:news_app/ui/widget/loading_view.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsList extends StatefulWidget {
  final Source source;
  const NewsList({
    super.key,
    required this.source
  });

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList>  {

  int page = 1;
  int pageSize = 10;
  List<Article> newList = [];
  bool lastPage = false;
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();

    controller.addListener(
            (){
              if(controller.position.atEdge && controller.position.pixels!=0 ){
                    viewPage();
              }
    });
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future:ApiManager.getArticles(
          sourceId: widget.source.id,
          page: page,
          pageSize: pageSize
        ) ,
        builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting && newList.isEmpty ){
          return LoadingView();
        }else if((snapshot.hasError || snapshot.data?.status!="ok" && newList.isEmpty) ){
         return ErrorView(error: snapshot.error.toString(), onRetryClick: (){});
        }if((snapshot.data!.articles?? []).isNotEmpty){
          if(snapshot.data!.articles!.length < 10){
            lastPage = true;
          }
          newList.addAll(snapshot.data!.articles!);
        }else{
          lastPage = true;
        }
        return ListView.builder(
            controller: controller,
            itemCount: newList.length ,
            itemBuilder: (context, index) =>  mapSourceToWidget(newList[index]));
        },
    );
  }

  Widget mapSourceToWidget(Article article) {
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
             SizedBox(height: 10,),
             Text(article.source?.name??"",style: AppStyle.titleNews,),
             Text(article.title??"",style: AppStyle.sourceTitleTextStyle.copyWith(color: AppColors.black),),
             Align(
               alignment: AlignmentGeometry.centerRight,
                 child: Text(formatTimeAgo(article.publishedAt??""),style: AppStyle.dateNews,))
           ],
        ),
      ),
    );
  }
  String formatTimeAgo(String date){
    DateTime dateTime = DateTime.parse(date);
    return timeago.format(dateTime);
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  void viewPage() {
    if(lastPage == false){
      page++;
      setState(() {});
    }
  }
}
