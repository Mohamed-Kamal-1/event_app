import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';

import '../../core/colors/app_color.dart';

typedef OnSelectedIndex = void Function(int index);

class AppBottomNavigation extends StatefulWidget {
  OnSelectedIndex? onSelectedIndex;

  AppBottomNavigation(this.onSelectedIndex);

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: AppColor.bluePrimaryColor,
        notchMargin: 6,
        elevation: 0,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              widget.onSelectedIndex?.call(index);
              selectIndex = index;
            });
          },
          currentIndex: selectIndex,
          elevation: 0,
          backgroundColor: AppColor.bluePrimaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: AppColor.whitePrimaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.warehouse_outlined),
              label: context.appLocal.home,
              activeIcon: Icon(Icons.warehouse),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: context.appLocal.map,
              activeIcon: Icon(Icons.location_on),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: context.appLocal.love,
              activeIcon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: context.appLocal.profile,
              activeIcon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
