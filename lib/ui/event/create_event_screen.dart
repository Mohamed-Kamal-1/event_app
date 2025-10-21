import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/core/images/app_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
  return Scaffold(
    appBar: AppBar(
      foregroundColor: AppColor.bluePrimaryColor,
      title: Text('Create Event',style: textTheme.titleMedium?.copyWith(
        color: AppColor.bluePrimaryColor
      ),),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16)
              ),
              child: Image.asset(AppImage.gaming)),
        ],
      ),
    ),
  );
  }
}
