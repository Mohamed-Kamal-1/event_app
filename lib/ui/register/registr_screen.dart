import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/core/images/app_image.dart';
import 'package:evently_app/ui/register/app_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../l10n/app_localizations.dart';

class RegistrScreen extends StatelessWidget {
  const RegistrScreen({super.key});

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
              SizedBox(height: 24,),
              AppFormField(labelText: appLocale.name, icon: Icons.person),
              AppFormField(
                labelText: appLocale.email,
                icon: Icons.mail,
                keyboardType: TextInputType.emailAddress,
              ),
              AppFormField(
                labelText: appLocale.password,
                icon: Icons.lock,
                isPassword: true,
              ),
              AppFormField(
                labelText: appLocale.rePassword,
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () {},
                child: Text(appLocale.createAccount),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appLocale.alreadyHaveAccount),
                  GestureDetector(
                    onTap: (){},
                    child: Text(appLocale.login,
                    style: textTheme.titleSmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: AppColor.bluePrimaryColor
                    ),
                    ),

                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
