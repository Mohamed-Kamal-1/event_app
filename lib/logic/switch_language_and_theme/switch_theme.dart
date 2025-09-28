import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../core/colors/app_color.dart';
import '../../providers/app_theme_provider.dart';


class AppSwitchTheme extends StatefulWidget{

  @override
  State<AppSwitchTheme> createState() => _AppSwitchThemeState();
}

class _AppSwitchThemeState extends State<AppSwitchTheme> {
  @override
  Widget build(BuildContext context) {
   AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
   return  AnimatedToggleSwitch<ThemeMode>.rolling(
     height: 45.76,
     current: appThemeProvider.getSelectedThemMode(),
     values: appThemeProvider.getModes(),

     onChanged: (newMode) {
      setState(() {
       appThemeProvider.changeTheme(newMode);
      });
     },

     iconBuilder: (value, foreground) {
      if (value == ThemeMode.light) {
       return Icon(EvaIcons.sun_outline);
      } else {
       return Icon(EvaIcons.moon_outline);
      }
     },

     style: ToggleStyle(
      indicatorColor: AppColor.bluePrimaryColor,
      backgroundColor: Colors.transparent,
      borderColor: AppColor.bluePrimaryColor,
     ),
    );
  }
}
