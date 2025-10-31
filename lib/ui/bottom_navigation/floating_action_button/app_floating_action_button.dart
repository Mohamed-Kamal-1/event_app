import 'package:evently_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/app_color.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: Key('key2'),
      elevation: 0,

      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.CreateEventScreen.name);
      },
      child: Icon(Icons.add, size: 35),
      backgroundColor: AppColor.bluePrimaryColor,
      foregroundColor: AppColor.whitePrimaryColor,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(360),
        side: BorderSide(color: AppColor.whitePrimaryColor, width: 5),
      ),
    );
  }
}
