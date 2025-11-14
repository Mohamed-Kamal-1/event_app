import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/colors/app_color.dart';
import '../../../../database/model/category.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../tabs/events_tab.dart';

class EventHomeTap extends StatefulWidget {
     int selectedCategoryIndex ;
   EventHomeTap({super.key,required this.selectedCategoryIndex,});

  @override
  State<EventHomeTap> createState() => _EventHomeTapState();
}

class _EventHomeTapState extends State<EventHomeTap> {
  @override
  Widget build(BuildContext context) {
  AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
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
        widget.selectedCategoryIndex,
            (index, category) {
          setState(() {
            widget.selectedCategoryIndex = index;
          });
        },),
    );
  }
}
