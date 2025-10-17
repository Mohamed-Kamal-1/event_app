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
          Image.asset(AppImage.primaryLogo),
          SizedBox(width: 10),
          Text(appLocale!.evently, style: textTheme.headlineMedium),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => Size(100, 54);
}
