import'package:flutter/material.dart';

class DOutlinedButtonTheme{

  DOutlinedButtonTheme._();



  static final lightOutlinedButtonTheme=OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: Color(0x54cc90)),
      textStyle: const TextStyle(fontSize: 16 ,color: Colors.white ,fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),

  );
  static final darkOutlinedButtonTheme=OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: Color(0x54cc90)),
      textStyle: const TextStyle(fontSize: 16 ,color: Colors.white ,fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );


}