import 'package:news_app/data/model/source.dart';

class SourceResponse {
  String? status;
  List<Source>? sources;

  SourceResponse({
      this.status,
      this.sources,});

  SourceResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['sources'] != null) {
      sources = [];
      json['sources'].forEach((v) {
        sources?.add(Source.fromJson(v));
      });
    }
  }
SourceResponse copyWith({
  String? status,
  List<Source>? sources,
}) =>
    SourceResponse(
      status: status ?? this.status,
      sources: sources ?? this.sources,
    );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (sources != null) {
      map['sources'] = sources?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

