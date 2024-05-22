// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/translations/localization_service.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // shared pref init
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';

  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';

  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) =>
      _sharedPreferences!.setBool(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _sharedPreferences!.getBool(_lightThemeKey) ?? false;

  /// save current locale
  static void setCurrentLanguage(String languageCode) =>
      _sharedPreferences!.setString(_currentLocalKey, languageCode);

  /// get current locale
  static Locale getCurrentLocal() {
    String? langCode = _sharedPreferences!.getString(_currentLocalKey);
    // default language is english
    if (langCode == null) {
      return LocalizationService.defaultLanguage;
    }
    return LocalizationService.supportedLanguages[langCode]!;
  }

  /// save generated fcm token
  static Future<void> setFcmToken(String token) =>
      _sharedPreferences!.setString(_fcmTokenKey, token);

  /// get generated fcm token
  static String? getFcmToken() => _sharedPreferences!.getString(_fcmTokenKey);

  /// clear all data from shared pref except the current language
  static Future<void> clearExceptLanguage() async {
    // Step 1: Retrieve the current language from shared preferences
    final currentLanguage = _sharedPreferences!.getString(_currentLocalKey);

    // Step 2: Clear all the shared preferences
    await _sharedPreferences!.clear();

    // Step 3: Set the current language back to the shared preferences
    if (currentLanguage != null) {
      setCurrentLanguage(currentLanguage);
    }
  }

  /// clear all data from shared pref
  static Future<void> clear() async => await _sharedPreferences!.clear();
}
