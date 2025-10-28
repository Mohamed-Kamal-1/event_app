import 'package:evently_app/core/images/app_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:icons_plus/icons_plus.dart';

class Category {
  int id;
  String title;
  IconData iconData;

  Category({required this.id, required this.iconData, required this.title});

  static List<Category> getCategories({ bool includeAll = true}) {
    List<Category> list = [];
    if (includeAll == true) {
      list.add(Category(id: 0, iconData: FontAwesome.compass, title: 'All'));
    }
    list.addAll([
      Category(id: 1, iconData: FontAwesome.bicycle_solid, title: 'sport'),
      Category(id: 2, iconData: FontAwesome.playstation_brand, title: 'Gaming'),
      Category(id: 3, iconData: Icons.work_history_rounded, title: 'Workshop'),
      Category(id: 4, iconData: Icons.calendar_today, title: 'Birthday'),
    ]);

    return list;
  }

  static String getCategoryImage(int categoryId) {
    switch (categoryId) {
      case 1:
        return AppImage.sport;
      case 2:
        return AppImage.gaming;
      case 3:
        return AppImage.workshop;
      case 4:
        return AppImage.birthday;
    }
    return '';
  }
}
