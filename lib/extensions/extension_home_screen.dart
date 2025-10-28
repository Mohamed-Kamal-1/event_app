import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  TextTheme get fonts =>
      Theme
          .of(this)
          .textTheme;

  BottomNavigationBarThemeData get bottomNavBarTheme =>Theme
    .of(this).bottomNavigationBarTheme;
  AppBarThemeData get appBarTheme => Theme
    .of(this).appBarTheme;


  AppLocalizations get appLocal => AppLocalizations.of(this)!;

  void showMessageDialog(
      String message,
      { String? posActionText,
        VoidCallback? onPosActionClick,
        String? negActionText,
        VoidCallback? onNegActionClick,
        bool isDismissible = true
      }
      ){
    showDialog(context: this, builder: (context) {

      var actions = [
        TextButton(onPressed: (){
          Navigator.pop(context);
          onPosActionClick?.call();
        }, child: Text(posActionText ?? "ok"))
      ];
      if(negActionText !=null){
        actions.add(
            TextButton(onPressed: (){
              Navigator.pop(context);
              onNegActionClick?.call();
            },
                child: Text(negActionText))
        );

      }
      return AlertDialog(
        content: Row(
          children: [
            Text(message,
              style: context.fonts.bodyMedium?.copyWith(
                  color: Colors.black
              ),)
          ],
        ),
        actions: actions,
      );
    },
        barrierDismissible: isDismissible
    );
  }


  void showLoadingDialog({String? message,
    bool isDismissible = true}){
    showDialog(context: this, builder:(context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            Text(message ?? "Loading...")
          ],
        ),
      );
    },
        barrierDismissible: isDismissible
    );
  }
}

enum CategoryName { all, sport, gaming, workshop, birthday, non }

extension LocalizationExtension on AppLocalizations {

  String translate(String title) {
    switch (title) {
      case 'all':
        return CategoryName.all.name;
      case 'sport':
        return CategoryName.sport.name;
      case 'gaming':
        return CategoryName.gaming.name;
      case 'workshop':
        return CategoryName.workshop.name;
      case 'birthday':
        return CategoryName.birthday.name;
    }
    return CategoryName.non.name;
  }
}
