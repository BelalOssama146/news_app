import 'package:flutter/material.dart';
import 'package:news_app/data/model/source.dart';
import 'package:news_app/ui/base/base_api_state.dart';
import 'package:news_app/ui/screens/tabs/news_tabs/news_list.dart';
import 'package:news_app/ui/screens/tabs/news_tabs/tabs_view_model.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:news_app/ui/utils/app_style.dart';
import 'package:news_app/ui/widget/error_view.dart';
import 'package:news_app/ui/widget/loading_view.dart';
import 'package:provider/provider.dart';

class TabList extends StatefulWidget {
  final String categoryId;
  const TabList({super.key,required this.categoryId});

  @override
  State<TabList> createState() => _TabListState();
}

class _TabListState extends State<TabList> {
  TabsViewModel viewModel = TabsViewModel();
  int selectedTabIndex = 0;
  @override
  void initState() {
    super.initState();
    viewModel.getSources(widget.categoryId);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => viewModel,
      builder: (context,_){
        viewModel = Provider.of(context);
        if(viewModel.sourceApiState is BaseLoadingState){
          return LoadingView();
        }else if(viewModel.sourceApiState is BaseErrorState){
          String errorMessage = (viewModel.sourceApiState as BaseErrorState).errorMessage;
          return ErrorView(error: errorMessage, onRetryClick: (){});
        }else{
          List<Source> sources = (viewModel.sourceApiState as BaseSuccessState).data;
          return buildTabList(sources);
        }
      }
    );

  }

  Widget buildTabList(List<Source> sources){
    List<Widget> tabs = sources.map((source) => mapSourceToTab(source,
        selectedTabIndex == sources.indexOf(source))).toList();

    List<Widget> tabsBody = sources.map((source) => NewsList(source: source,)).toList();
    return DefaultTabController(
      length: sources.length,
      child: Column(
        children: [
          SizedBox(height: 15,),
          TabBar(
            onTap: (index){
              setState(() {selectedTabIndex = index;});
            },
            tabs: tabs,
            isScrollable: true,
            indicatorColor: AppColors.transparent,dividerColor: AppColors.transparent,),
          Expanded(child: TabBarView(children:tabsBody,)),
        ],
      ),
    );
  }

  Widget mapSourceToTab(Source source,bool isSelected) =>
      Container(
    decoration: BoxDecoration(
      border: BoxBorder.all(color: AppColors.appBarColor,width: 2),
      borderRadius: BorderRadius.circular(25),
      color: isSelected? AppColors.appBarColor : AppColors.transparent
    ),
    padding: EdgeInsets.all(12),
    child:Text(source.name??"",
      style: AppStyle.sourceTitleTextStyle.copyWith(
        color: isSelected? AppColors.white: AppColors.appBarColor),
    ),
  );
}
// return FutureBuilder<SourceResponse>(
// future: ApiManager.getSources(widget.categoryId),
// builder:(context, snapshot){
// if(snapshot.hasError){
// return ErrorView(error: snapshot.error.toString(), onRetryClick: (){});
// }else if(snapshot.hasData){
// return buildTabList(snapshot.data!.sources!);
// }else{
// return LoadingView();
// }
// }
// );
