import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_app/core/icons/app_icon.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/colors/app_color.dart';

enum Languages { english, arabic }

class AppSwitchLanguage extends StatefulWidget {
  static List<Languages> languages = [Languages.english, Languages.arabic];
  double height;

  AppSwitchLanguage({this.height = 50.0});

  @override
  State<AppSwitchLanguage> createState() => _AppSwitchLanguageState();
}

class _AppSwitchLanguageState extends State<AppSwitchLanguage> {
  Languages geSelectedLanguage() {
    if (appLanguageProvider.getAppLanguage() == 'en') {
      return Languages.english;
    }
    return Languages.arabic;
  }

  late Languages selectedLanguage = geSelectedLanguage();

  late AppLanguageProvider appLanguageProvider =
      Provider.of<AppLanguageProvider>(context);

  @override
  Widget build(BuildContext context) {
    AppLanguageProvider appLanguageProvider = Provider.of<AppLanguageProvider>(
      context,
    );
    return AnimatedToggleSwitch<Languages>.rolling(
      animationCurve: Curves.fastOutSlowIn,

      height: widget.height,
      current: selectedLanguage,
      values: AppSwitchLanguage.languages,

      onChanged: (item) {
        selectedLanguage = item;

        if (selectedLanguage == Languages.english) {
          appLanguageProvider.changeLanguage('en');
        } else {
          appLanguageProvider.changeLanguage('ar');
        }
      },

      iconBuilder: (value, foreground) {
        if (value == Languages.english) {
          return SvgPicture.asset(AppIcon.ic_us, width: 40);
        } else {
          return SvgPicture.asset(AppIcon.ic_eg, width: 40);
        }
      },

      style: ToggleStyle(
        indicatorBorder: BoxBorder.all(
          width: 3,
          color: AppColor.bluePrimaryColor,
        ),
        backgroundColor: Colors.transparent,
        borderColor: AppColor.bluePrimaryColor,
      ),
    );
  }
}
