import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/model/source_response.dart';

class OnlineDataSource {
  Future<SourceResponse> getSources(String categoryId) async {
    return ApiManager.getSources(categoryId);
  }
}
