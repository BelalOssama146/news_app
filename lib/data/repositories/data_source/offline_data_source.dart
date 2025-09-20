import 'package:news_app/data/hive_utils/hive_utils.dart';
import 'package:news_app/data/model/source_response.dart';

class OfflineDataSource {
  HiveUtils hiveUtils;

  OfflineDataSource(this.hiveUtils);

  Future<SourceResponse?> getSources(String categoryId) async {
    return await hiveUtils.getSources(categoryId);
  }

  Future<void> saveSources(
    String categoryId,
    SourceResponse sourceResponse,
  ) async {
    return await hiveUtils.saveSource(categoryId, sourceResponse);
  }
}
