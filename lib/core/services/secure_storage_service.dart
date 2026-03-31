import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const _tokenKey = 'token';
  static const _refreshTokenKey = 'refreshToken';

  static Future<void> saveToken(String token) async {
    await _writeValue(_tokenKey, token);
  }

  static Future<void> saveRefreshToken(String token) async {
    await _writeValue(_refreshTokenKey, token);
  }

  static Future<String?> getToken() async {
    return _readValue(_tokenKey);
  }

  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } on MissingPluginException {
      await _clearFallbackStorage();
    } on PlatformException catch (error) {
      log('Secure storage clear failed, using fallback storage: $error');
      await _clearFallbackStorage();
    }
  }

  static Future<void> _writeValue(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } on MissingPluginException {
      await _writeFallbackValue(key, value);
    } on PlatformException catch (error) {
      log(
        'Secure storage write failed for $key, using fallback storage: $error',
      );
      await _writeFallbackValue(key, value);
    }
  }

  static Future<String?> _readValue(String key) async {
    try {
      return await _storage.read(key: key);
    } on MissingPluginException {
      return _readFallbackValue(key);
    } on PlatformException catch (error) {
      log(
        'Secure storage read failed for $key, using fallback storage: $error',
      );
      return _readFallbackValue(key);
    }
  }

  static Future<void> _writeFallbackValue(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> _readFallbackValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> _clearFallbackStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}
