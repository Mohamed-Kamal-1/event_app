import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';

import '../../database/model/category.dart';
import '../app_bar/tab_bar/tabBar_item.dart';

typedef OnTabSelected = Function(int index, Category category);

class EventsTab extends StatelessWidget {
  final List<Category> categories;
  final int currentTabIndex;
  final OnTabSelected onTabSelected;
  final bool reverse;

  const EventsTab(
    this.categories,
    this.currentTabIndex,
    this.onTabSelected, {
    super.key,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 16),
        tabAlignment: TabAlignment.start,
        isScrollable: true,

        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        onTap: (index) {
          onTabSelected(index, categories[index]);
        },
        tabs: categories.map((category) {
          return TabBarItem(
            reverse: reverse,
            title: translateTitle(category.title, context),
            icon: category.iconData,
            currentIndex: currentTabIndex,
            index: categories.indexOf(category),
          );
        }).toList(),
      ),
    );
  }

  String translateTitle(String title, BuildContext context) {
    switch (title) {
      case 'All':
        {
          return context.appLocal.all;
        }
      case 'sport':
        {
          return context.appLocal.sport;
        }
      case 'Gaming':
        {
          return context.appLocal.gaming;
        }
      case 'Workshop':
        {
          return context.appLocal.workshop;
        }
      case 'Birthday':
        {
          return context.appLocal.birthday;
        }
    }
    return 'non';
  }
}
