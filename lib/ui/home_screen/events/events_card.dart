import 'package:evently_app/database/model/category.dart';
import 'package:evently_app/database/model/event.dart';
import 'package:evently_app/database/model/user_dao.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:evently_app/providers/app_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/colors/app_color.dart';
import '../../../core/images/app_image.dart';
import '../../../providers/app_theme_provider.dart';

class EventsCard extends StatefulWidget {
  Event event;

  EventsCard({required this.event});

  @override
  State<EventsCard> createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  @override
  Widget build(BuildContext context) {
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context);
    bool isThemeDark =
        (appThemeProvider.getSelectedThemMode() == ThemeMode.dark)
        ? true
        : false;

    return Container(
      height: 203.06,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(widget.event.getCategoryImage()),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (isThemeDark)
                  ? AppColor.darkBluePrimaryColor
                  : AppColor.whitePrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.event.date?.day}',
                  style: context.fonts.titleMedium?.copyWith(
                    color: AppColor.bluePrimaryColor,
                  ),
                ),
                Text(
                  '${widget.event.date?.month}',
                  style: context.fonts.titleSmall?.copyWith(
                    color: AppColor.bluePrimaryColor,
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 49,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (isThemeDark)
                  ? AppColor.darkBluePrimaryColor
                  : AppColor.whitePrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.event.desc}', style: context.fonts.titleSmall),
                GestureDetector(
                  onTap: () {
                    toggleFavorite(widget.event);
                  },
                  child: Icon(
                    (provider.isFavorite(widget.event)
                        ? Icons.favorite
                        : Icons.favorite_border),
                    size: 34,
                    color: AppColor.bluePrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void toggleFavorite(Event event) async {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(
      context,
      listen: false,
    );
    var user = provider.getUser();
    var isFavorite = provider.isFavorite(event);
    if (isFavorite) {
      user = await UserDao.removeEventFromFavorites(
        provider.getUser()!,
        event.id,
      );
    } else {
      user = await UserDao.addEventToFavorites(provider.getUser()!, event.id);
    }
    provider.updateFavorites(user.favorites);
    setState(() {
      widget.event.isFavorite = !isFavorite;
    });
  }
}
