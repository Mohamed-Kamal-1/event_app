import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/providers/app_auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../app_form_field.dart';
import '../validationForm/validators.dart';

class AppForm extends StatefulWidget {
  const AppForm({super.key});

  @override
  State<AppForm> createState() => _AppFormState();
}


class _AppFormState extends State<AppForm> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
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
            labelText: appLocale!.name,
            icon: Icons.person,
            validator: (name) {
              return validationInputNameAndPhone(name, context);
            },
            controller: nameController,
          ),

          AppFormField(
            labelText: appLocale.email,
            icon: Icons.mail,
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              return validationInputEmail(email, context);
            },
            controller: emailController,
          ),

          AppFormField(
            labelText: appLocale.phone,
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (phone) {
              return validationInputNameAndPhone(phone, context);
            },
            controller: phoneController,
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

          AppFormField(
            labelText: appLocale.rePassword,
            icon: Icons.lock,
            isPassword: true,
            validator: (rePassword) {
              String passController = passwordController.text;
              return validationInputRePassword(
                rePassword,
                context,
                passwordController: passController,
              );
            },
            controller: passwordController,
          ),

          SizedBox(height: 16),
          ElevatedButton(
            onPressed: (isLoading)
                ? null
                : () {
                    createAccount();
                  },
            child: (isLoading)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      CircularProgressIndicator(color: AppColor.bluePrimaryColor,),
                      SizedBox(width: 16,),
                      Text(appLocale.createAccount),
                    ],
                  )
                : Text(appLocale.createAccount),
          ),
        ],
      ),
    );
  }

  void createAccount() async {
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
    AuthResponse response = await appAuthProvider.register(
      emailController.text,
      passwordController.text,
      nameController.text,
      phoneController.text,
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
      errorMessage = 'Weak Password';
    } else if (response.failure == AuthFailure.emailAlreadyExist) {
      errorMessage = 'Email Already Exist';
    } else {
      errorMessage = 'Something Went Wrong';
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(errorMessage)));
  }
}
