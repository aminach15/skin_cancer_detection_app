import 'package:flutter/material.dart';
import 'package:my_skin_cancer_app/utils/constants/colors.dart';
import 'package:my_skin_cancer_app/utils/themes/custom_themes/appbar_theme.dart';
import 'package:my_skin_cancer_app/utils/themes/custom_themes/elevated_button_theme.dart';
import 'package:my_skin_cancer_app/utils/themes/custom_themes/outlined_button_theme.dart';
import 'package:my_skin_cancer_app/utils/themes/custom_themes/text_theme.dart';

class DAppTheme{
  DAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: DColors.primary,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: DAppBarTheme.lightAppBarTheme,
    textTheme: DTextTheme.lightTextTheme,
    elevatedButtonTheme: DELevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: DOutlinedButtonTheme.lightOutlinedButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: DColors.primary,
    scaffoldBackgroundColor: Colors.black12,
    textTheme: DTextTheme.darkTextTheme,
    elevatedButtonTheme: DELevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: DOutlinedButtonTheme.darkOutlinedButtonTheme,
  );
}