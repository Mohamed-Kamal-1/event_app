import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/providers/app_auth_registered_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../register/app_form_field.dart';
import '../../register/validationForm/validators.dart';

class AppFormLoginScreen extends StatefulWidget {
  const AppFormLoginScreen({super.key});

  @override
  State<AppFormLoginScreen> createState() => _AppFormLoginScreenState();
}

class _AppFormLoginScreenState extends State<AppFormLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? appLocale = AppLocalizations.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppFormField(
            labelText: appLocale!.email,
            icon: Icons.mail,
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              return validationInputEmail(email, context);
            },
            controller: emailController,
          ),

          AppFormField(
            labelText: appLocale.password,
            icon: Icons.lock,
            isPassword: true,
            validator: (password) {
              return validationInputPassword(password, context);
            },
            controller: passwordController,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: (isLoading)
                ? null
                : () {
                    login();
                  },
            child: (isLoading)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      CircularProgressIndicator(
                        color: AppColor.bluePrimaryColor,
                      ),
                      SizedBox(width: 16),
                      Text(appLocale.login),
                    ],
                  )
                : Text(appLocale.login),
          ),
        ],
      ),
    );
  }

  void login() async {
    if (validatForm() == false) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    AppAuthProvider appAuthProvider = Provider.of<AppAuthProvider>(
      context,
      listen: false,
    );
    AuthResponse response = await appAuthProvider.signIn(
      emailController.text,
      passwordController.text,
    );

    if (response.success == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('every thing is ok')));
    } else {
      handelError(response);
    }
    setState(() {
      isLoading = false;
    });
  }

  bool validatForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void handelError(AuthResponse response) {
    String errorMessage;
    if (response.failure == AuthFailure.weakPassword) {
      errorMessage = 'Wrong Email or Password';
    } else {
      errorMessage = 'Something Went Wrong';
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}
