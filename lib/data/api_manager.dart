import 'dart:convert';
import 'package:http/http.dart'  ;
import 'package:news_app/data/model/articles_response.dart';
import 'package:news_app/data/model/source_response.dart';

abstract class ApiManager{
  static const String _apiKey = "528b049ec4cb4dee87b084c38dde328f";
  static const String _baseUrl = "https://newsapi.org";
  static const String _sourceEndPoint = "/v2/top-headlines/sources";
  static const String _articlesEndPoint = "/v2/everything";

  static Future<SourceResponse>  getSources(String category)async{
    Response serverResponse = await get(Uri.parse("$_baseUrl$_sourceEndPoint?apiKey=$_apiKey&category=$category"));
    print("🟢 Status Code => ${serverResponse.statusCode}");
    print("🟡 Response Body => ${serverResponse.body}");
     if(serverResponse.statusCode >= 200 && serverResponse.statusCode < 300){
      Map json = jsonDecode(serverResponse.body) as Map;
      SourceResponse response = SourceResponse.fromJson(json);
      print("response : sources = ${response.sources}");
      return response;
     }
      else{
        throw "Something went wrong,please try again later";
     }
    }
  static Future<ArticlesResponse> getArticles({
    String? sourceId,
    String? query,
    int? page,
    int? pageSize
  }) async{
    final url = Uri.https("newsapi.org",_articlesEndPoint,{
      "apiKey" : _apiKey,
      if(sourceId!= null && sourceId.isNotEmpty) "sources" : sourceId,
      if(query!= null && query.isNotEmpty) "q" : query,
      if(page!=null) "page" : page.toString(),
      if(pageSize!=null) "pageSize" : pageSize.toString()
    });


    Response serverResponse = await get(url);
   if(serverResponse.statusCode >= 200 && serverResponse.statusCode < 300){
     Map json= jsonDecode(serverResponse.body) as Map ;
     return ArticlesResponse.fromJson(json);
   }
   else{
     throw "Something went wrong please try again";
   }
  }
}