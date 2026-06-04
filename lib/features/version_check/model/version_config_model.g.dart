// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionConfigModel _$VersionConfigModelFromJson(Map<String, dynamic> json) =>
    VersionConfigModel(
      androidLatestVersion: json['androidLatestVersion'] as String,
      androidMinRequiredVersion: json['androidMinRequiredVersion'] as String,
      androidForceUpdate: json['androidForceUpdate'] as bool,
      iosLatestVersion: json['iosLatestVersion'] as String,
      iosMinRequiredVersion: json['iosMinRequiredVersion'] as String,
      iosForceUpdate: json['iosForceUpdate'] as bool,
      androidStoreUrl: json['androidStoreUrl'] as String?,
      iosStoreUrl: json['iosStoreUrl'] as String?,
    );

Map<String, dynamic> _$VersionConfigModelToJson(VersionConfigModel instance) =>
    <String, dynamic>{
      'androidLatestVersion': instance.androidLatestVersion,
      'androidMinRequiredVersion': instance.androidMinRequiredVersion,
      'androidForceUpdate': instance.androidForceUpdate,
      'iosLatestVersion': instance.iosLatestVersion,
      'iosMinRequiredVersion': instance.iosMinRequiredVersion,
      'iosForceUpdate': instance.iosForceUpdate,
      'androidStoreUrl': instance.androidStoreUrl,
      'iosStoreUrl': instance.iosStoreUrl,
    };
