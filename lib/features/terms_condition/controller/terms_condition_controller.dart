import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/features/terms_condition/model/terms_condition_model.dart';

class TermsConditionController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final Rx<TermsConditionModel?> termsCondition = Rx<TermsConditionModel?>(null);

  final ApiClient _apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    fetchTermsAndConditions();
  }

  Future<void> fetchTermsAndConditions() async {
    try {
      isLoading.value = true;
      error.value = '';

      debugPrint('📡 [TERMS AND CONDITIONS] Fetching terms and conditions from API...');
      final response = await _apiClient.get(ApiEndpoints.termsAndConditions);

      debugPrint('📡 [TERMS AND CONDITIONS] Response status: ${response.statusCode}');
      debugPrint('📡 [TERMS AND CONDITIONS] Response data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data.containsKey('data')) {
          final policyData = data['data'] as Map<String, dynamic>;
          final policy = TermsConditionModel.fromJson(policyData);
          termsCondition.value = policy;
          debugPrint('✅ [TERMS AND CONDITIONS] Successfully fetched terms and conditions');
        } else {
          error.value = 'Invalid response format';
          debugPrint(
            '❌ [TERMS AND CONDITIONS] Invalid response format: ${data.runtimeType}',
          );
        }
      } else {
        error.value = 'Failed to fetch terms and conditions: ${response.statusCode}';
        debugPrint(
          '❌ [TERMS AND CONDITIONS] Failed to fetch terms and conditions: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      error.value = 'Error fetching terms and conditions: $e';
      debugPrint('❌ [TERMS AND CONDITIONS] Error fetching terms and conditions: $e');
      debugPrint('❌ [TERMS AND CONDITIONS] Stack trace: $stackTrace');
    } finally {
      isLoading.value = false;
    }
  }

}
