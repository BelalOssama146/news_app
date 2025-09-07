import 'package:flutter/material.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/data/model/source.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:news_app/ui/utils/app_style.dart';
import 'package:news_app/ui/widget/error_view.dart';
import 'package:news_app/ui/widget/loading_view.dart';

class NewsList extends StatefulWidget {
  final Source source;
  const NewsList({
    super.key,
    required this.source
  });

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  int page = 1;
  int pageSize = 10;
  List<Article> articles = [];
  ScrollController controller = ScrollController();
  bool isLoading = false;
  bool hasError = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadNews();
    controller.addListener(
            (){
              if(controller.position.atEdge){
                if(controller.offset !=0 && controller.position.pixels!=0){
                  loadNews();
                }
              }
    });
  }
  Future<void> loadNews()async{
    if(isLoading) return;
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try{
      final newListArticle = await ApiManager.getArticles(
          sourceId: widget.source.id,
          page: page,
          pageSize: pageSize
      );

      if(!mounted) return;
      setState(() {
        articles.addAll(newListArticle.articles??[]);
        page++;
      });
    }catch (e){
      if(!mounted) return;
      setState(() {
        hasError = true;
        errorMessage = e.toString();
      });
    }
      if(!mounted) return;
      setState(() {
        isLoading = false;
      });

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(hasError){
      return ErrorView(error: errorMessage.toString(), onRetryClick:loadNews );
    }
    if(articles.isEmpty && isLoading){
      return LoadingView();
    }
    return ListView.builder(
      controller: controller,
      itemCount: articles.length ,
      itemBuilder: (context, index) =>  mapSourceToWidget(articles[index]));
  }

  Widget mapSourceToWidget(Article article) {
    return Padding(
      padding: const EdgeInsets.only(left: 26,right: 26),
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}
