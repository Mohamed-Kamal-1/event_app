import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/core/images/app_image.dart';
import 'package:evently_app/core/routes/app_routes.dart';
import 'package:evently_app/logic/switch_language_and_theme/switch_theme.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/intro_screen/onBoarding_image.dart';
import '../../l10n/app_localizations.dart';
import '../../logic/switch_language_and_theme/switch_language.dart';
import '../app_bar/event_appbar_Screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);

    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations? appLocale = AppLocalizations.of(context);
    return Scaffold(
      appBar: EventAppBarScreen(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              (appThemeProvider.getSelectedThemMode() == ThemeMode.dark)
                  ? OnBoardingDarkThemeImage.darkMidOnboarding
                  : OnBoardingLightThemeImage.midOnboarding,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.429,
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    appLocale!.personalizeYourExperience,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColor.bluePrimaryColor,
                    ),
                  ),
                  Text(
                    appLocale.personalizeDescription,
                    style: textTheme.titleSmall,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocale.language,
                            style: textTheme.titleMedium?.copyWith(
                              color: AppColor.bluePrimaryColor,
                            ),
                          ),
                          AppSwitchLanguage(),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appLocale.theme,
                            style: textTheme.titleMedium?.copyWith(
                              color: AppColor.bluePrimaryColor,
                            ),
                          ),
                          AppSwitchTheme(),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.bluePrimaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.LoginScreen.name);
                    },
                    child: Text(
                      appLocale.letsStart,

                      style: textTheme.titleMedium?.copyWith(
                        color: AppColor.whitePrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
