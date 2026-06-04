import 'package:json_annotation/json_annotation.dart';

part 'version_config_model.g.dart';

@JsonSerializable()
class VersionConfigModel {
  final String androidLatestVersion;
  final String androidMinRequiredVersion;
  final bool androidForceUpdate;
  final String iosLatestVersion;
  final String iosMinRequiredVersion;
  final bool iosForceUpdate;
  final String? androidStoreUrl;
  final String? iosStoreUrl;

  VersionConfigModel({
    required this.androidLatestVersion,
    required this.androidMinRequiredVersion,
    required this.androidForceUpdate,
    required this.iosLatestVersion,
    required this.iosMinRequiredVersion,
    required this.iosForceUpdate,
    this.androidStoreUrl,
    this.iosStoreUrl,
  });

  factory VersionConfigModel.fromJson(Map<String, dynamic> json) =>
      _$VersionConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$VersionConfigModelToJson(this);
}
