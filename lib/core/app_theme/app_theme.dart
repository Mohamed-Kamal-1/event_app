import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    // canvasColor: AppColor.gold,
    appBarTheme: AppBarTheme(backgroundColor: AppColor.whitePrimaryColor),
    // scaffoldBackgroundColor: AppColor.whitePrimaryColor,
    scaffoldBackgroundColor: Colors.brown,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        color: AppColor.black,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.inter(
        color: AppColor.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.inter(
        color: AppColor.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),

      headlineMedium: GoogleFonts.inter(
        color: AppColor.bluePrimaryColor,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    ),

    inputDecorationTheme: InputDecorationThemeData(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.bluePrimaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.gray, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),

      labelStyle: GoogleFonts.inter(
        color: AppColor.gray,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.inter(
        color: AppColor.gray,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: AppColor.gray,
      suffixIconColor: AppColor.gray,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.bluePrimaryColor,
        foregroundColor: AppColor.whitePrimaryColor,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
    ),

    // iconTheme: IconThemeData(
    //   color: Colors.redAccent,
    // ),
  );

  static ThemeData darkTheme = ThemeData(
    // canvasColor: AppColor.gold,
    appBarTheme: AppBarTheme(backgroundColor: AppColor.darkBluePrimaryColor),
    scaffoldBackgroundColor: AppColor.darkBluePrimaryColor,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        color: AppColor.offWhite,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.inter(
        color: AppColor.offWhite,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.inter(
        color: AppColor.offWhite,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),

      headlineMedium: GoogleFonts.inter(
        color: AppColor.bluePrimaryColor,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.bluePrimaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.bluePrimaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),

      labelStyle: GoogleFonts.inter(
        color: AppColor.offWhite,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.inter(
        color: AppColor.offWhite,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: AppColor.offWhite,
      suffixIconColor: AppColor.offWhite,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.bluePrimaryColor,
        foregroundColor: AppColor.whitePrimaryColor,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
    ),
  );
}
