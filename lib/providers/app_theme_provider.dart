import 'package:evently_app/SharedPreferences/app_shared_preferences.dart';
import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
   AppSharedPreferences? appSharedPreferences = AppSharedPreferences.getInstance();

  late ThemeMode _themeMode;

  AppThemeProvider(){
    _themeMode = appSharedPreferences!.getTheme()!;
  }

  static AppThemeProvider? appThemeProvider;



  List<ThemeMode> getModes() {
    return [ThemeMode.light, ThemeMode.dark];
  }

  ThemeMode getSelectedThemMode() {
    return _themeMode;
  }

  void changeTheme(ThemeMode newTheme) {
    _themeMode = newTheme;
    AppSharedPreferences.saveTheme(_themeMode);
    notifyListeners();
  }
}
