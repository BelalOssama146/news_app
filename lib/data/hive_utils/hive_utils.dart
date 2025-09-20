import 'package:hive/hive.dart';
import 'package:news_app/data/model/source_response.dart';

class HiveUtils {
  Future<SourceResponse?> getSources(String categoryId) async {
    var box = await Hive.openBox('tab_list');
    return box.get(categoryId);
  }

  Future<void> saveSource(
    String categoryId,
    SourceResponse sourceResponse,
  ) async {
    var box = await Hive.openBox('tab_list');
    return box.put(categoryId, sourceResponse);
  }
}

class SourceResponseAdapter extends TypeAdapter<SourceResponse> {
  @override
  final typeId = 0;

  @override
  SourceResponse read(BinaryReader reader) {
    return SourceResponse.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, SourceResponse obj) {
    writer.write(obj.toJson());
  }
}
