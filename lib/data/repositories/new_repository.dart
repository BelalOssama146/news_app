import 'package:news_app/data/model/source_response.dart';

abstract class NewRepository {
  Future<SourceResponse> getSources(String categoryId);
}
