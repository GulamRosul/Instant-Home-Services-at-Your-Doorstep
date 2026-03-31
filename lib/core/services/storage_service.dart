import 'package:shared_preferences/shared_preferences.dart';

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
  static String? getAvatar() => _prefs?.getString(_avatarKey);

  /// 🔹 Clear (Simple)
  static Future<void> clearAll() async {
    await _prefs?.clear();
    isLoggedIn = false;
  }
}