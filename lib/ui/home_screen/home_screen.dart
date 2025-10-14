import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        toolbarHeight: 174,
        backgroundColor: AppColor.bluePrimaryColor,

        title: Column(
          children: [
            Text("Welcome Back ✨"),
            Text("mohamed kamal"),
            Text('Cairo'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.light_mode_outlined,
              color: AppColor.whitePrimaryColor,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 5, right: 16),
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: AppColor.whitePrimaryColor,
              onPressed: () {},
              child: Text(context.appLocal!.en,style: context.textTheme.titleSmall?.copyWith(
                color: AppColor.bluePrimaryColor,


              ),),
            ),
          ),
        ],
      ),
    );
  }
}
