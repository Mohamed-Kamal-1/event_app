import 'package:flutter/material.dart';

import '../../../core/colors/app_color.dart';

class AppFloatingActionButton extends StatefulWidget {
  const AppFloatingActionButton({super.key});

  @override
  State<AppFloatingActionButton> createState() => _AppFloatingActionButtonState();
}

class _AppFloatingActionButtonState extends State<AppFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
    elevation: 0,

    onPressed: () {},
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
