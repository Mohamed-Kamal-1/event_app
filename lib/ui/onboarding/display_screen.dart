import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';

import '../app_bar/event_appbar_Screen.dart';
import 'onboarding_data.dart';

class DisplayScreen extends StatelessWidget {
  final OnboardingData onboardingData;

 const DisplayScreen({super.key, required this.onboardingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const EventAppBarScreen(),
      body: Container(
        margin:const EdgeInsets.symmetric(horizontal: 16, vertical: 39),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: Image.asset(onboardingData.image)),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 44,
                children: [
                  Text(context.appLocal.titleScreen1, style: context.fonts.titleSmall?.copyWith(
                    color: AppColor.bluePrimaryColor,
                  )),
                  Text(
                    context.appLocal.descriptionScreen1,
                    style: context.fonts.titleSmall,
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
