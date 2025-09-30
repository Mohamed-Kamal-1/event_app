import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/core/images/app_image.dart';
import 'package:evently_app/ui/register/app_form_field.dart';
import 'package:evently_app/ui/register/validationForm/validators.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../l10n/app_localizations.dart';

class RegistrScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

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

              AppFormField(
                labelText: appLocale.name,
                icon: Icons.person,
                validator: (name) {
                  if (name?.trim().isEmpty == true) {
                    return 'Please Enter  ${appLocale.name} ';
                  }
                  return null;
                },
                controller: nameController,
              ),

              AppFormField(
                labelText: appLocale.email,
                icon: Icons.mail,
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email?.trim().isEmpty == true) {
                    return 'Please Enter  ${appLocale.email} ';
                  } else if (!isValidEmail(email)) {
                    return 'Please Enter valid Email';
                  }
                  return null;
                },
                controller: emailController,
              ),


              AppFormField(
                labelText: appLocale.phone,
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (email) {
                  if (email?.trim().isEmpty == true) {
                    return 'Please Enter  ${appLocale.phone} ';
                  }
                  if (!isValidEmail(email)) {
                    return 'Please Enter valid Email';
                  }
                  return null;
                },
                controller: phoneController,
              ),

              AppFormField(
                labelText: appLocale.password,
                icon: Icons.lock,
                isPassword: true,
                validator: (password) {
                  if (password?.trim().isEmpty == true) {
                    return 'Please Enter  ${appLocale.password} ';
                  }
                  if(password!.length < 6){
                    return 'Please Enter valid password';
                  }

                  return null;
                },
                controller: passwordController,
              ),


              AppFormField(
                labelText: appLocale.rePassword,
                icon: Icons.lock,
                isPassword: true,
                validator: (rePassword) {
                  if (rePassword?.trim().isEmpty == true) {
                    return 'Please Enter  ${appLocale.rePassword} ';
                  }
                  if(passwordController.text != rePassword){
                    return "Password does not match";
                  }
                  return null;
                },
                controller: passwordController,

              ),


              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                },
                child: Text(appLocale.createAccount),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appLocale.alreadyHaveAccount),
                  GestureDetector(
                    onTap: () {

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
