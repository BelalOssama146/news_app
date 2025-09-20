import 'package:news_app/data/model/source_response.dart';

abstract class OnlineDataSource {
  Future<SourceResponse> getSources(String categoryId);
}
