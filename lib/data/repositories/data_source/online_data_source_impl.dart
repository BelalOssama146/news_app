import 'package:injectable/injectable.dart';
import 'package:news_app/data/api_manager.dart';
import 'package:news_app/data/model/source_response.dart';
import 'package:news_app/data/repositories/data_source/online_data_source.dart';

@Injectable(as: OnlineDataSource)
class OnlineDataSourceImpl extends OnlineDataSource {
  Future<SourceResponse> getSources(String categoryId) async {
    return ApiManager.getSources(categoryId);
  }
}
