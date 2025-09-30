import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppFormField extends StatefulWidget {
  String labelText;
  IconData icon;
  TextInputType keyboardType;
  bool isPassword;

  AppFormField({
    required this.labelText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool isTextvisable = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: isTextvisable,
        style: GoogleFonts.jockeyOne(fontSize: 18, fontStyle: FontStyle.italic),
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
