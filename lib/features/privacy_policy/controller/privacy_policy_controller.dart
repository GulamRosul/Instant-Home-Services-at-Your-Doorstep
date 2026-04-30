import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/privacy_policy/model/privacy_policy_model.dart';

class PrivacyPolicyController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final Rx<PrivacyPolicyModel?> privacyPolicy = Rx<PrivacyPolicyModel?>(null);

  final ApiClient _apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading.value = true;
      error.value = '';

      debugPrint('📡 [PRIVACY POLICY] Fetching privacy policy from API...');
      final response = await _apiClient.get(ApiEndpoints.privacyPolicy);

      debugPrint('📡 [PRIVACY POLICY] Response status: ${response.statusCode}');
      debugPrint('📡 [PRIVACY POLICY] Response data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          final policy = PrivacyPolicyModel.fromJson(data);
          privacyPolicy.value = policy;
          debugPrint('✅ [PRIVACY POLICY] Successfully fetched privacy policy');
        } else {
          error.value = 'Invalid response format';
          debugPrint(
            '❌ [PRIVACY POLICY] Invalid response format: ${data.runtimeType}',
          );
        }
      } else {
        error.value = 'Failed to fetch privacy policy: ${response.statusCode}';
        debugPrint(
          '❌ [PRIVACY POLICY] Failed to fetch privacy policy: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      error.value = 'Error fetching privacy policy: $e';
      debugPrint('❌ [PRIVACY POLICY] Error fetching privacy policy: $e');
      debugPrint('❌ [PRIVACY POLICY] Stack trace: $stackTrace');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
