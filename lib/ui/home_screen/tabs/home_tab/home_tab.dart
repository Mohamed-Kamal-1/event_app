import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/core/images/app_image.dart';
import 'package:evently_app/database/model/EventsDao.dart';
import 'package:evently_app/database/model/category.dart';
import 'package:evently_app/database/model/user_dao.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:evently_app/providers/app_auth_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/ui/home_screen/events/events_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../tabs/events_tab.dart';

class HomeTab extends StatefulWidget {
  HomeTab();

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedCategoryIndex = 0;
  List<Category> allCategories = Category.getCategories(includeAll: true);

  @override
  Widget build(BuildContext context) {
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context);
    return Column(
      spacing: 16,
      children: [
        Container(
          decoration:
          BoxDecoration(
              color: (appThemeProvider.getSelectedThemMode() == ThemeMode.light)
                  ? AppColor.bluePrimaryColor
              :AppColor.darkBluePrimaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              )
          ),
          child: EventsTab(
            Category.getCategories(includeAll: true),
            selectedCategoryIndex,
                (index, category) {
              setState(() {
                selectedCategoryIndex = index;
              });
            },),
        ),
        Expanded(
          child: StreamBuilder(
            stream: EventsDao.getRealTimeUpdatesForEvents(
              allCategories[selectedCategoryIndex].id != 0
                  ? allCategories[selectedCategoryIndex].id
                  : null,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Something went Wrong"));
              }
              var events = snapshot.data?.toList();
              events?.forEach((element) {});
              if (events == null || events.isEmpty == true) {
                return Center(
                  child: Text(
                    "No Events Found",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  var event = events[index];
                  var isFavorite = provider.isFavorite(event);
                  event.isFavorite = isFavorite;
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.EventDetails.name,
                        arguments: event,
                      );
                    },
                    child: EventsCard(event: event),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemCount: events.length ?? 0,
              );
            },
          ),
        ),
      ],
    );
  }
}
