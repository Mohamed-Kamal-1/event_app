import 'package:evently_app/core/colors/app_color.dart';
import 'package:flutter/material.dart';
import '../../core/images/app_image.dart';
import '../../l10n/app_localizations.dart';

class EventAppBarScreen extends StatelessWidget implements PreferredSizeWidget {
  const EventAppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations? appLocale = AppLocalizations.of(context);
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImage.primaryLogo,width: 50,),
          SizedBox(width: 10),
          Text(appLocale!.evently, style: textTheme.headlineMedium?.copyWith(
            color: AppColor.bluePrimaryColor
          )),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => Size(100, 54);
}
