import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/extensions/extension_home_screen.dart';
import 'package:flutter/material.dart';

import '../app_bar/event_appbar_Screen.dart';
import 'onboarding_data.dart';

class DisplayScreen extends StatelessWidget {
  OnboardingData onboardingData;

  DisplayScreen({required this.onboardingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EventAppBarScreen(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 39),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Image.asset(onboardingData.image)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 44,
                children: [
                  Text(onboardingData.title, style: context.fonts.titleSmall?.copyWith(
                    color: AppColor.bluePrimaryColor,
                  )),
                  Text(
                    onboardingData.description,
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
