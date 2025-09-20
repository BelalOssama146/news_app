import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/data/model/source_response.dart';
import 'package:news_app/data/repositories/data_source/offline_data_source.dart';
import 'package:news_app/data/repositories/data_source/online_data_source.dart';
import 'package:news_app/data/repositories/new_repository.dart';

@Injectable(as: NewRepository)
class NewRepositoryImpl extends NewRepository {
  OnlineDataSource onlineDataSource;
  OfflineDataSource offlineDataSource;
  Connectivity connectivity;

  NewRepositoryImpl(
    this.onlineDataSource,
    this.offlineDataSource,
    this.connectivity,
  );

  Future<SourceResponse> getSources(String categoryId) async {
    final List<ConnectivityResult> connectivityResult = await (connectivity
        .checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      SourceResponse sourceResponse = await onlineDataSource.getSources(
        categoryId,
      );
      await offlineDataSource.saveSources(categoryId, sourceResponse);
      return sourceResponse;
    } else {
      return (await offlineDataSource.getSources(categoryId))!;
    }
  }
}
