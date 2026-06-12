import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/services/api_client.dart';
import '../../../core/utils/constants/apiendpoint.dart';
import '../model/version_config_model.dart';
import '../dialogue/version_check_dialogue.dart';

class VersionCheckController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  late String _currentVersion;
  late VersionConfigModel _versionConfig;
  bool _updateCheckCompleted = false;
  bool isBlockedByForceUpdate = false;

  Future<void> checkForUpdate() async {
    try {
      if (_updateCheckCompleted) return;

      _currentVersion = await _getDeviceVersion();
      _versionConfig = await _fetchVersionConfig();

      final isUpdateNeeded = _isUpdateNeeded(
        _currentVersion,
        _getLatestVersion(),
      );

      if (isUpdateNeeded) {
        final isForceUpdate = _isForceUpdate(
          _getMinRequiredVersion(),
          _currentVersion,
        );
        _showUpdateDialog(isForceUpdate);
      }

      _updateCheckCompleted = true;
    } catch (e) {
      debugPrint('Version check error: $e');
      _updateCheckCompleted = true;
    }
  }

  Future<String> _getDeviceVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<VersionConfigModel> _fetchVersionConfig() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.versionCheck);

      print('current version: $_currentVersion');
      print('Device platform: ${Platform.operatingSystem}');
      print('Version config response: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final innerData = data['data'] as Map<String, dynamic>;
        final versionData = innerData['data'] as Map<String, dynamic>;
        return VersionConfigModel.fromJson(versionData);
      } else {
        throw Exception('Failed to fetch version config');
      }
    } catch (e) {
      debugPrint('Error fetching version config: $e');
      rethrow;
    }
  }

  bool _isUpdateNeeded(String currentVersion, String latestVersion) {
    try {
      final current = Version.parse(currentVersion);
      final latest = Version.parse(latestVersion);
      return latest > current;
    } catch (e) {
      debugPrint('Version parse error: $e');
      return false;
    }
  }

  bool _isForceUpdate(String minRequiredVersion, String currentVersion) {
    try {
      final min = Version.parse(minRequiredVersion);
      final current = Version.parse(currentVersion);
      return current < min;
    } catch (e) {
      debugPrint('Version parse error: $e');
      return false;
    }
  }

  String _getLatestVersion() {
    return Platform.isAndroid
        ? _versionConfig.androidLatestVersion
        : _versionConfig.iosLatestVersion;
  }

  String _getMinRequiredVersion() {
    return Platform.isAndroid
        ? _versionConfig.androidMinRequiredVersion
        : _versionConfig.iosMinRequiredVersion;
  }

  bool _getForceUpdateFlag() {
    return Platform.isAndroid
        ? _versionConfig.androidForceUpdate
        : _versionConfig.iosForceUpdate;
  }

  String? _getStoreUrl() {
    return Platform.isAndroid
        ? _versionConfig.androidStoreUrl
        : _versionConfig.iosStoreUrl;
  }

  void _showUpdateDialog(bool isForceUpdate) {
    final shouldForce = isForceUpdate || _getForceUpdateFlag();

    if (shouldForce) {
      isBlockedByForceUpdate = true; // 🔥 ADD THIS
    }

    Get.dialog(
      VersionCheckDialogue(
        currentVersion: _currentVersion,
        latestVersion: _getLatestVersion(),
        isForceUpdate: shouldForce,
        onUpdate: () => _openAppStore(),
        onCancel: () => shouldForce ? _showExitConfirmation() : Get.back(),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _openAppStore() async {
    final storeUrl = _getStoreUrl();
    try {
      if (await canLaunchUrl(Uri.parse(storeUrl!))) {
        await launchUrl(
          Uri.parse(storeUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('Error opening app store: $e');
    }
  }

  void _showExitConfirmation() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,

        title: Text(
          'exit_app'.tr,
          style: getTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        content: Text('this_update_is_required'.tr, 
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black54,),),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr, style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,),)),
          TextButton(onPressed: () => _exitApp(), child: Text('exit'.tr, style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,),)),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _exitApp() {
    SystemNavigator.pop();
  }
}
