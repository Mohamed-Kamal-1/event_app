import 'package:evently_app/core/icons/app_icon.dart';
import 'package:evently_app/logic/switch_language_and_theme/switch_language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/colors/app_color.dart';
import '../../core/images/app_image.dart';
import '../../core/routes/app_routes.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/app_auth_provider.dart';
import '../../providers/app_auth_signIn_provider.dart';
import 'app_form/app_form_login_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = AuthSignIn();

  @override
  Widget build(BuildContext context) {
    AppAuthProvider appAuthProvider = Provider.of<AppAuthProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations? appLocale = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.bluePrimaryColor,
        title: Text(
          textAlign: TextAlign.center,
          appLocale!.login,
          style: textTheme.titleMedium?.copyWith(
            color: AppColor.bluePrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 24, horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
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

              AppFormLoginScreen(),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appLocale.doNotHaveAccount, style: textTheme.titleSmall),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.RegistrScreen.name,
                      );
                    },
                    child: Text(
                      appLocale.createAccount,
                      style: textTheme.titleSmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColor.bluePrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 34),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: AppColor.bluePrimaryColor,
                    height: 1.5,
                    width: 129,
                  ),
                  Text(
                    appLocale.or,
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 21,
                      color: AppColor.bluePrimaryColor,
                    ),
                  ),
                  Container(
                    color: AppColor.bluePrimaryColor,
                    height: 1.5,
                    width: 129,
                  ),
                ],
              ),
              SizedBox(height: 24),
              InkWell(
                onTap: () async {
                  await appAuthProvider.signinwithGoogle();
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.HomeScreen.name,
                  );
                },
                child: Container(
                  height: 57.67,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      width: 1.5,
                      color: AppColor.bluePrimaryColor,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcon.ic_google),
                      SizedBox(width: 15),
                      Text(
                        'Login With Google',
                        style: textTheme.titleMedium?.copyWith(
                          color: AppColor.bluePrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.26,
                child: SafeArea(child: AppSwitchLanguage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
