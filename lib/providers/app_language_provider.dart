import 'package:evently_app/SharedPreferences/app_shared_preferences.dart';
import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier{
  static final AppSharedPreferences? _appLanguageSharedPreferences = AppSharedPreferences.getInstance();
  late String appLanguage;
  AppLanguageProvider(){
    appLanguage =_appLanguageSharedPreferences!.getLanguage()!;
  }

  void changeLanguage(String newLanguage){
    appLanguage = newLanguage;
    _appLanguageSharedPreferences!.saveLanguage(appLanguage);
    notifyListeners();

  }
  String getAppLanguage()  {
    return appLanguage;
  }
}