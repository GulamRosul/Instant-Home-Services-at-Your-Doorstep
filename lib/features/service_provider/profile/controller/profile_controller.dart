import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';

class ProfileController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Profile Information
  var name = ''.obs;
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
  final errorMessage = ''.obs;
  final hasLoadedProfile = false.obs;

  final ImagePicker _picker = ImagePicker();

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
      final data = _asMap(responseMap['data']);
      final nestedData = _asMap(data?['data']);
      final rest = _asMap(nestedData?['rest']);

      if (response.statusCode != 200 || rest == null) {
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

      name.value = _buildFullName(rest['firstName'], rest['lastName']);
      email.value = _asString(rest['email']);
      phone.value = _asString(rest['phone']);
      profession.value = _asString(rest['profession']);
      bio.value = _asString(rest['bio']);
      streetAddress.value = _asString(rest['streetAddress']);
      city.value = _asString(rest['city']);
      state.value = _asString(rest['state']);
      zipCode.value = _asString(rest['zipCode']);

      final avatarUrl = _asString(rest['avatar']);
      imagePath.value = avatarUrl;

      hasLoadedProfile.value = true;
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

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  // Methods to update (placeholders)
  void updateName(String val) => name.value = val;
  void updateEmail(String val) => email.value = val;
  void updatePhone(String val) => phone.value = val;
  void updateProfession(String val) => profession.value = val;
  void updateBio(String val) => bio.value = val;
  void updateStreet(String val) => streetAddress.value = val;
  void updateCity(String val) => city.value = val;
  void updateState(String val) => state.value = val;
  void updateZip(String val) => zipCode.value = val;

  void _clearProfile() {
    name.value = '';
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
        nestedData?['message'] ?? data?['message'] ?? responseMap['message'];

    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    return null;
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
}
