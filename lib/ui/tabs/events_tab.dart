import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';

import '../../database/model/category.dart';
import '../../l10n/app_localizations.dart';
import '../app_bar/tab_bar/tabBar_item.dart';
typedef OnTabSelected = Function(int index);
class EventsTab extends StatelessWidget {
  OnTabSelected onTabSelected;
  int currentTabIndex;
  EventsTab({required this.onTabSelected,required this.currentTabIndex});
  List<Category> categories = Category.getCategories();

  @override
  Widget build(BuildContext context) {

    return TabBar(
      onTap: (index) {
        onTabSelected(index);
      },
      tabs: categories.map((category) {
        return TabbarItem(
          title:context.appLocal.translate(category.title).toString(),
          icon: category.iconData,
          index: category.id,
          currentIndex:currentTabIndex ,
        );
      }).toList(),
    );
  }
}
