import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:evently_app/providers/app_auth_provider.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/ui/app_bar/tab_bar/tabBar_item.dart';
import 'package:evently_app/ui/bottom_navigation/app_bottom_navigation.dart';
import 'package:evently_app/ui/bottom_navigation/floating_action_button/app_floating_action_button.dart';
import 'package:evently_app/ui/home_screen/tabs/favourite_tab/favourite_tab.dart';
import 'package:evently_app/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:evently_app/ui/home_screen/tabs/map_tab/map_tab.dart';
import 'package:evently_app/ui/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:evently_app/ui/tabs/events_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/model/app_user.dart';
import '../../database/model/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentsSelectIndexBottom = 0;
  int currentsSelectIndexTabItem = 0;
  List<Category> categories = Category.getCategories(includeAll: true);
  List<Widget> tabs = [HomeTab(), MapTab(), FavouriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {

    AppLanguageProvider appLanguageProvider = Provider.of<AppLanguageProvider>(
      context,
    );
    AppAuthProvider appAuthProvider = Provider.of<AppAuthProvider>(context);
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    AppUser? user = appAuthProvider.getUser();

    return Scaffold(
      appBar:
      (currentsSelectIndexBottom == 0)
      ? AppBar(
        toolbarHeight: 140,
        backgroundColor: context.appBarTheme.backgroundColor,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back ✨',
              style: context.fonts.titleSmall?.copyWith(
                color: AppColor.whitePrimaryColor,
              ),
            ),
            (user?.name?.isEmpty == false)
                ? Text(
                    user?.name ?? "",
                    style: context.fonts.headlineSmall?.copyWith(
                      color: AppColor.whitePrimaryColor,
                    ),
                  )
                : CircularProgressIndicator(),
            SizedBox(height: 11),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColor.whitePrimaryColor,
                ),
                Text(
                  'Cairo , Egypt',
                  style: context.fonts.titleSmall?.copyWith(
                    color: AppColor.whitePrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (appThemeProvider.getSelectedThemMode() == ThemeMode.light) {
                appThemeProvider.changeTheme(ThemeMode.dark);
              } else {
                appThemeProvider.changeTheme(ThemeMode.light);
              }
            },
            icon: Icon(Icons.sunny),
          ),
          FloatingActionButton(
            mini: true,
            elevation: 0,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(25),
            ),
            backgroundColor: AppColor.whitePrimaryColor,
            onPressed: () {
              if (appLanguageProvider.getAppLanguage() == 'en') {
                appLanguageProvider.changeLanguage('ar');
              } else {
                appLanguageProvider.changeLanguage('en');
              }
            },
            child: Text(
              context.appLocal.en,
              style: context.fonts.titleSmall?.copyWith(
                color: AppColor.bluePrimaryColor,
              ),
            ),
          ),
        ],
      )
      :null,
      bottomNavigationBar: AppBottomNavigation((index) {
        currentsSelectIndexBottom = index;
        setState(() {});
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AppFloatingActionButton(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.bluePrimaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            // put function
            // child: EventsTab(
            //   categories: categories,
            //   currentTabIndex: currentsSelectIndexTabItem,
            //
            //   onTabSelected: (index, category) {
            //     setState(() {
            //       currentsSelectIndexTabItem = index;
            //     });
            //   },
            // ),

            // child: Eve,
          ),

          Expanded(child: tabs[currentsSelectIndexBottom]),
        ],
      ),
    );
  }
}
