import 'package:json_annotation/json_annotation.dart';

part "property_files.g.dart";

@JsonSerializable()

class PropertyFile {
  int? Id;
  int? PropertyId;
  String? DownloadUrls;

  PropertyFile({
    this.Id,
    this.PropertyId,
    this.DownloadUrls,
  });

factory PropertyFile.fromJson(Map<String, dynamic> json) => _$PropertyFileFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyFileToJson(this);
}
