import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/core/images/app_image.dart';
import 'package:evently_app/core/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../l10n/app_localizations.dart';
import 'app_form/app_form.dart';

class RegistrScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations? appLocale = AppLocalizations.of(context);

    return Scaffold(

      appBar: AppBar(
        foregroundColor: AppColor.bluePrimaryColor,
        title: Text(
          textAlign: TextAlign.center,
          appLocale!.register,
          style: textTheme.titleMedium?.copyWith(
            color: AppColor.bluePrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Image.asset(AppImage.registerLogo, fit: BoxFit.cover),
                  Text(
                    appLocale.evently,
                    style: GoogleFonts.jockeyOne(
                      textStyle: textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              AppForm(),

              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appLocale.alreadyHaveAccount,style: textTheme.titleSmall,),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.LoginScreen.name);
                    },
                    child: Text(
                      appLocale.login,
                      style: textTheme.titleSmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColor.bluePrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
