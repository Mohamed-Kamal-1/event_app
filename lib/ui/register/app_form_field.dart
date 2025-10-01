import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'app_form_field.dart';

typedef Validator = String? Function(String? text);

class AppFormField extends StatefulWidget {
  String labelText;
  IconData icon;
  TextInputType keyboardType;
  bool isPassword;
  Validator? validator;
  TextEditingController? controller;

  AppFormField({
    required this.labelText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.controller,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool isTextvisable = true;
  bool isLight = true;

  @override
  Widget build(BuildContext context) {
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    (appThemeProvider.getSelectedThemMode() == ThemeMode.dark)
        ? isLight = false
        : isLight;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isPassword ? isTextvisable : isTextvisable == false,
        validator: widget.validator,

        style: (isLight)
            ? GoogleFonts.jockeyOne(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: AppColor.black,
              )
            : GoogleFonts.jockeyOne(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: AppColor.whitePrimaryColor,
              ),
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Icon(
            widget.icon,
            // color: Theme.of(context).iconTheme.color,
          ),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isTextvisable = !isTextvisable;
                      print('is password is : ${widget.isPassword}');
                    });
                  },
                  child: Icon(
                    isTextvisable ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
