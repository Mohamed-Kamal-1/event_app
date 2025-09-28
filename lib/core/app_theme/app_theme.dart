import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_color.dart';


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    // canvasColor: AppColor.gold,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.brown,
    ),
    scaffoldBackgroundColor: Colors.brown,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        color: AppColor.black,
        fontWeight: FontWeight.bold
      ),
      headlineSmall: GoogleFonts.inter(
          color:AppColor.black,
          fontSize: 24,
          fontWeight: FontWeight.bold
      ),
      titleSmall: GoogleFonts.inter(
          color:AppColor.black,
          fontSize: 16,
          fontWeight: FontWeight.bold
      ),

       headlineMedium : GoogleFonts.inter(
            color:AppColor.bluePrimaryColor,
            fontSize: 36,
            fontWeight: FontWeight.bold
        )
    )
  );

  static ThemeData darkTheme = ThemeData(
    // canvasColor: AppColor.gold,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.darkBluePrimaryColor,
      ),
      scaffoldBackgroundColor:AppColor.darkBluePrimaryColor,
      textTheme: TextTheme(
          titleMedium: GoogleFonts.inter(
              fontSize: 20,
              color: AppColor.offWhite,
              fontWeight: FontWeight.bold
          ),
          headlineSmall: GoogleFonts.inter(
              color:AppColor.offWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold
          ),
          titleSmall: GoogleFonts.inter(
              color:AppColor.offWhite,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),

          headlineMedium : GoogleFonts.inter(
              color:AppColor.bluePrimaryColor,
              fontSize: 36,
              fontWeight: FontWeight.bold
          )
      )
  );
}
