import 'package:evently_app/core/colors/app_color.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

typedef Validator = String? Function(String? text);
typedef EditText = String? Function(String? text);

class AppFormField extends StatefulWidget {
  final String labelText;
  final EditText? editText;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool isPassword;
  final Validator? validator;
  final TextEditingController? controller;
  final int? lines;

  const AppFormField({super.key,
    required this.labelText,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.lines = 1,
    this.editText,
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
        onChanged: widget.editText,
        maxLines: widget.lines,
        controller: widget.controller,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isPassword ? isTextvisable : isTextvisable == false,
        validator: widget.validator,

        style: (isLight)
            ? GoogleFonts.jockeyOne(
                fontSize: 18,
                color: AppColor.bluePrimaryColor,
              )
            : GoogleFonts.jockeyOne(
                fontSize: 18,
                color: AppColor.whitePrimaryColor,
              ),
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isTextvisable = !isTextvisable;
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
