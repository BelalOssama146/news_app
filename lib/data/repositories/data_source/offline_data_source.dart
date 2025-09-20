import 'package:news_app/data/model/source_response.dart';

abstract class OfflineDataSource {
  Future<SourceResponse?> getSources(String categoryId);

  Future<void> saveSources(String categoryId, SourceResponse sourceResponse);
}
