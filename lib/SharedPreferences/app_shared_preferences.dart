import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static const String themeKey = 'theme';
  static const String languageKey = 'language';

  AppSharedPreferences._();

  static late SharedPreferences _sharedPreferences;

  static AppSharedPreferences? appSharedPreferences;

  static const String _light = 'light';
  static const String _dark = 'dark';

  static Future<void> init() async {
    if (appSharedPreferences == null) {
      appSharedPreferences = AppSharedPreferences._();
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  static Future<void> saveTheme(ThemeMode mode) async {
    var themeName = (mode == ThemeMode.light) ? _light : _dark;
    await _sharedPreferences.setString(themeKey, themeName);
  }
     ThemeMode? getTheme() {
    var themeName = _sharedPreferences.getString(themeKey);
    return themeName == _dark ? ThemeMode.dark : ThemeMode.light;
  }




   Future<void> saveLanguage(String language) async {
    _sharedPreferences.setString(AppSharedPreferences.languageKey, language);
  }

   String? getLanguage(){
    return _sharedPreferences.getString(AppSharedPreferences.languageKey) ?? 'en';
  }

  static AppSharedPreferences? getInstance() {
    if (appSharedPreferences == null) {
      throw Exception(
        "make sure to call init before using"
        "get Instance",
      );
    }
    return appSharedPreferences;
  }

  Future<void> intiSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
