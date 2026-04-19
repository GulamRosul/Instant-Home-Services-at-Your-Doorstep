import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';

class ProfileController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Profile Information
  var name = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var profession = ''.obs;
  var bio = ''.obs;

  var imagePath = "".obs;

  // Address Information
  var streetAddress = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var zipCode = ''.obs;

  final isLoading = false.obs;
  final isUpdatingProfile = false.obs;
  final errorMessage = ''.obs;
  final hasLoadedProfile = false.obs;

  final ImagePicker _picker = ImagePicker();
  String _firstName = '';
  String _lastName = '';

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile({bool isRefresh = false}) async {
    if (isLoading.value) {
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await SecureStorageService.getToken();

      if (token == null || token.trim().isEmpty) {
        if (!isRefresh) {
          _clearProfile();
        }
        errorMessage.value = 'Please sign in to view your profile.';
        return;
      }

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.authMe,
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final responseMap = _asMap(response.data) ?? <String, dynamic>{};
      final profileData = _extractProfileData(responseMap);

      debugPrint(
        'Profile fetch response: ${response.statusCode} ${response.data}',
      );

      if (response.statusCode != 200 || profileData == null) {
        if (!isRefresh) {
          _clearProfile();
        }

        errorMessage.value =
            _extractMessage(response.data) ?? 'Failed to load profile.';
        AppLoggerHelper.warning(
          'Profile request failed: ${response.statusCode} ${response.data}',
        );
        return;
      }

      await _applyProfileData(profileData);
      AppLoggerHelper.info('Fetched profile for ${email.value}');
    } on DioException catch (error) {
      if (!isRefresh) {
        _clearProfile();
      }

      errorMessage.value =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to load profile.';
      AppLoggerHelper.error('Profile fetch failed', error);
    } catch (error) {
      if (!isRefresh) {
        _clearProfile();
      }

      errorMessage.value = 'Failed to load profile.';
      AppLoggerHelper.error('Unexpected profile fetch error', error);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProfileField({
    required String fieldName,
    required String value,
  }) async {
    final normalizedField = fieldName.trim();
    final normalizedValue = value.trim();

    if (normalizedField.isEmpty || normalizedValue.isEmpty) {
      return false;
    }

    if (isUpdatingProfile.value) {
      return false;
    }

    try {
      isUpdatingProfile.value = true;
      errorMessage.value = '';

      final token = await SecureStorageService.getToken();

      if (token == null || token.trim().isEmpty) {
        final message = 'Please sign in to update your profile.';
        errorMessage.value = message;
        _showErrorSnackbar(message);
        return false;
      }

      final didUpdate = normalizedField == 'name'
          ? await _updateName(token: token, value: normalizedValue)
          : await _patchProfileField(
              token: token,
              fieldName: normalizedField,
              value: normalizedValue,
            );

      if (!didUpdate) {
        return false;
      }

      _showSuccessSnackbar(
        '${_fieldLabel(normalizedField)} updated successfully.',
      );
      return true;
    } on DioException catch (error) {
      final message =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to update profile.';
      errorMessage.value = message;
      AppLoggerHelper.error('Profile update failed', error);
      _showErrorSnackbar(message);
      return false;
    } catch (error) {
      const message = 'Failed to update profile.';
      errorMessage.value = message;
      AppLoggerHelper.error('Unexpected profile update error', error);
      _showErrorSnackbar(message);
      return false;
    } finally {
      isUpdatingProfile.value = false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    if (isUpdatingProfile.value) {
      return;
    }

    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      await updateProfileAvatar(pickedFile.path);
    }
  }

  Future<bool> updateProfileAvatar(String filePath) async {
    final normalizedPath = filePath.trim();

    if (normalizedPath.isEmpty) {
      return false;
    }

    if (isUpdatingProfile.value) {
      return false;
    }

    try {
      isUpdatingProfile.value = true;
      errorMessage.value = '';

      final token = await SecureStorageService.getToken();

      if (token == null || token.trim().isEmpty) {
        const message = 'Please sign in to update your profile picture.';
        errorMessage.value = message;
        _showErrorSnackbar(message);
        return false;
      }

      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          normalizedPath,
          filename: normalizedPath.split('/').last,
        ),
      });

      final response = await _apiClient.patch<dynamic>(
        ApiEndpoints.updateUserProfile,
        data: formData,
        options: Options(
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      AppLoggerHelper.info(
        'Profile avatar update response: ${response.statusCode} ${response.data}',
      );

      final avatarUrl = _extractAvatarUrl(response.data);
      if (response.statusCode != 200 || avatarUrl == null) {
        final message =
            _extractMessage(response.data) ??
            'Failed to update profile picture.';
        errorMessage.value = message;
        AppLoggerHelper.warning(
          'Profile avatar update failed: ${response.statusCode} ${response.data}',
        );
        _showErrorSnackbar(message);
        return false;
      }

      imagePath.value = avatarUrl;
      errorMessage.value = '';

      await StorageService.ensureInitialized();
      await StorageService.saveUser(avatar: avatarUrl);

      AppLoggerHelper.info('Profile avatar updated successfully');
      _showSuccessSnackbar('Profile picture updated successfully.');
      return true;
    } on DioException catch (error) {
      final message =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to update profile picture.';
      errorMessage.value = message;
      AppLoggerHelper.error('Profile avatar update failed', error);
      _showErrorSnackbar(message);
      return false;
    } catch (error) {
      const message = 'Failed to update profile picture.';
      errorMessage.value = message;
      AppLoggerHelper.error('Unexpected profile avatar update error', error);
      _showErrorSnackbar(message);
      return false;
    } finally {
      isUpdatingProfile.value = false;
    }
  }

  void _clearProfile() {
    _firstName = '';
    _lastName = '';
    name.value = '';
    firstName.value = '';
    lastName.value = '';
    email.value = '';
    phone.value = '';
    profession.value = '';
    bio.value = '';
    streetAddress.value = '';
    city.value = '';
    state.value = '';
    zipCode.value = '';
    imagePath.value = '';
    hasLoadedProfile.value = false;
  }

  Future<bool> _updateName({
    required String token,
    required String value,
  }) async {
    final nameParts = _splitName(value);

    final didUpdateFirstName = await _patchProfileField(
      token: token,
      fieldName: 'firstName',
      value: nameParts.$1,
    );

    if (!didUpdateFirstName) {
      return false;
    }

    final shouldUpdateLastName = nameParts.$2 != _lastName;

    if (!shouldUpdateLastName) {
      return true;
    }

    return _patchProfileField(
      token: token,
      fieldName: 'lastName',
      value: nameParts.$2,
    );
  }

  Future<bool> _patchProfileField({
    required String token,
    required String fieldName,
    required String value,
  }) async {
    final response = await _apiClient.patch<dynamic>(
      ApiEndpoints.authProfile,
      data: {'fildName': fieldName, 'value': value},
      options: Options(
        headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    final profileData = _extractProfileData(response.data);

    if (response.statusCode != 200 || profileData == null) {
      final message =
          _extractMessage(response.data) ?? 'Failed to update profile.';
      errorMessage.value = message;
      AppLoggerHelper.warning(
        'Profile update failed for $fieldName: ${response.statusCode} ${response.data}',
      );
      _showErrorSnackbar(message);
      return false;
    }

    errorMessage.value = '';
    await _applyProfileData(profileData);
    AppLoggerHelper.info('Updated profile field $fieldName');
    return true;
  }

  Future<void> _applyProfileData(Map<String, dynamic> profileData) async {
    errorMessage.value = '';
    _firstName = _asString(profileData['firstName']);
    _lastName = _asString(profileData['lastName']);
    firstName.value = _firstName;
    lastName.value = _lastName;
    name.value = _buildFullName(_firstName, _lastName);
    email.value = _asString(profileData['email']);
    phone.value = _asString(profileData['phone']);
    profession.value = _asString(profileData['profession']);
    bio.value = _asString(profileData['bio']);
    streetAddress.value = _asString(profileData['streetAddress']);
    city.value = _asString(profileData['city']);
    state.value = _asString(profileData['state']);
    zipCode.value = _asString(profileData['zipCode']);
    imagePath.value = _asString(profileData['avatar']);
    hasLoadedProfile.value = true;

    await StorageService.ensureInitialized();
    await StorageService.saveUser(
      email: email.value,
      firstName: _firstName,
      lastName: _lastName,
      avatar: imagePath.value,
    );
  }

  Map<String, dynamic>? _extractProfileData(dynamic responseData) {
    final responseMap = _asMap(responseData);
    if (responseMap == null) {
      return null;
    }

    final data = _asMap(responseMap['data']);
    if (data == null) {
      return null;
    }

    // Handle { data: { user: { ... } } }
    if (data.containsKey('user')) {
      final userData = _asMap(data['user']);
      if (userData != null) {
        return userData;
      }
    }

    // Handle { data: { data: { rest: { ... } } } }
    final nestedData = _asMap(data['data']);
    final rest = _asMap(nestedData?['rest']);

    return rest ?? nestedData ?? data;
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return value.map((key, item) => MapEntry(key.toString(), item));
    }

    return null;
  }

  String? _extractMessage(dynamic responseData) {
    final responseMap = _asMap(responseData);
    if (responseMap == null) {
      return null;
    }

    final data = _asMap(responseMap['data']);
    final nestedData = _asMap(data?['data']);

    final message =
        nestedData?['message'] ??
        data?['message'] ??
        responseMap['message'] ??
        responseMap['status'];

    if (message != null && message.toString().trim().isNotEmpty) {
      return message.toString();
    }

    return null;
  }

  String? _extractAvatarUrl(dynamic responseData) {
    final responseMap = _asMap(responseData);
    if (responseMap == null) {
      return null;
    }

    final data = responseMap['data'];
    if (data is String && data.trim().isNotEmpty) {
      return data.trim();
    }

    final dataMap = _asMap(data);
    final avatar =
        dataMap?['avatar'] ?? dataMap?['data']?['avatar'] ?? dataMap?['url'];

    final avatarUrl = _asString(avatar);
    return avatarUrl.isEmpty ? null : avatarUrl;
  }

  String _asString(dynamic value) {
    if (value == null) {
      return '';
    }

    final text = value.toString().trim();
    return text.toLowerCase() == 'null' ? '' : text;
  }

  String _buildFullName(dynamic firstName, dynamic lastName) {
    final first = _asString(firstName);
    final last = _asString(lastName);
    final fullName = [first, last].where((part) => part.isNotEmpty).join(' ');
    return fullName;
  }

  (String, String) _splitName(String fullName) {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return ('', '');
    }

    if (parts.length == 1) {
      return (parts.first, '');
    }

    return (parts.first, parts.sublist(1).join(' '));
  }

  String _fieldLabel(String fieldName) {
    switch (fieldName) {
      case 'name':
        return 'Name';
      case 'firstName':
        return 'First name';
      case 'lastName':
        return 'Last name';
      case 'streetAddress':
        return 'Street address';
      case 'zipCode':
        return 'Zip code';
      default:
        if (fieldName.isEmpty) {
          return 'Profile';
        }

        final words = fieldName.split(RegExp(r'(?=[A-Z])'));
        return words
            .where((word) => word.isNotEmpty)
            .map(
              (word) =>
                  '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
            )
            .join(' ');
    }
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Profile updated',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF065F46),
      colorText: Get.theme.colorScheme.onPrimary,
      margin: const EdgeInsets.all(16),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Update failed',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF7F1D1D),
      colorText: Get.theme.colorScheme.onPrimary,
      margin: const EdgeInsets.all(16),
    );
  }
}
