import 'package:shared_preferences/shared_preferences.dart';
import 'package:protiva502/core/services/secure_storage_service.dart';

class StorageService {
  StorageService._();

  static SharedPreferences? _prefs;

  static bool isLoggedIn = false;

  // Keys
  static const _isLoggedInKey = 'isLoggedIn';
  static const _userIdKey = 'userId';
  static const _usernameKey = 'username';
  static const _emailKey = 'email';
  static const _firstNameKey = 'firstName';
  static const _lastNameKey = 'lastName';
  static const _roleKey = 'role';
  static const _avatarKey = 'avatar';
  static const _forgotPasswordEmailKey = 'forgotPasswordEmail';

  /// 🔹 Init
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    isLoggedIn = _prefs?.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> ensureInitialized() async {
    if (_prefs != null) return;
    await init();
  }

  /// 🔹 Login State
  static Future<void> makeLoggedIn() async {
    await _prefs?.setBool(_isLoggedInKey, true);
    isLoggedIn = true;
  }

  static Future<void> makeLoggedOut() async {
    await _prefs?.setBool(_isLoggedInKey, false);
    isLoggedIn = false;
  }

  /// 🔹 Save User (ALL IN ONE)
  static Future<void> saveUser({
    String? userId,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    String? avatar,
  }) async {
    if (userId != null) await _prefs?.setString(_userIdKey, userId);
    if (username != null) await _prefs?.setString(_usernameKey, username);
    if (email != null) await _prefs?.setString(_emailKey, email);
    if (firstName != null) await _prefs?.setString(_firstNameKey, firstName);
    if (lastName != null) await _prefs?.setString(_lastNameKey, lastName);
    if (role != null) await _prefs?.setString(_roleKey, role);

    if (avatar != null && avatar.isNotEmpty) {
      await _prefs?.setString(_avatarKey, avatar);
    }
  }

  /// 🔹 Get User
  static String? getUserId() => _prefs?.getString(_userIdKey);
  static String? getUsername() => _prefs?.getString(_usernameKey);
  static String? getEmail() => _prefs?.getString(_emailKey);
  static String? getFirstName() => _prefs?.getString(_firstNameKey);
  static String? getLastName() => _prefs?.getString(_lastNameKey);
  static String? getAvatar() => _prefs?.getString(_avatarKey);
  static String? getRole() => _prefs?.getString(_roleKey);

  static bool hasActiveSession() {
    return isLoggedIn;
  }

  static String getDisplayName() {
    final firstName = getFirstName()?.trim() ?? '';
    final lastName = getLastName()?.trim() ?? '';
    final fullName = '$firstName $lastName'.trim();

    if (fullName.isNotEmpty) {
      return fullName;
    }

    final username = getUsername()?.trim();
    if (username != null && username.isNotEmpty) {
      return username;
    }

    final email = getEmail()?.trim();
    if (email != null && email.isNotEmpty) {
      return email;
    }

    return 'Guest User';
  }

  /// 🔹 Clear (Simple)
  static Future<void> clearAll() async {
    await _prefs?.clear();
    await SecureStorageService.clearAll();
    isLoggedIn = false;
  }

  /// 🔹 Forgot Password Email
  static Future<void> saveForgotPasswordEmail(String email) async {
    await _prefs?.setString(_forgotPasswordEmailKey, email);
  }

  static String? getForgotPasswordEmail() =>
      _prefs?.getString(_forgotPasswordEmailKey);

  static Future<void> clearForgotPasswordEmail() async {
    await _prefs?.remove(_forgotPasswordEmailKey);
  }
}
