import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:icons_plus/icons_plus.dart';

class Category {
  int id;
  String title;
  IconData iconData;

  Category({required this.id, required this.iconData, required this.title});

  static List<Category> getCategories() {
    return [
      Category(id: 0, iconData: FontAwesome.compass, title: 'All'),
      Category(id: 1, iconData: FontAwesome.bicycle_solid, title: 'sport'),
      Category(id: 2, iconData: FontAwesome.playstation_brand, title: 'Gaming'),
      Category(id: 3, iconData: Icons.work_history_rounded, title: 'Workshop'),
      Category(id: 4, iconData: Icons.calendar_today, title: 'Birthday'),
    ];
  }
}
