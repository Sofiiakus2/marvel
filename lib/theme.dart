import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const primaryColor = Color(0xFFa61924);


final themeData = ThemeData();

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  textTheme: textTheme,
  dividerTheme: const DividerThemeData(
    // color: Colors.black,
    thickness: 1,
    space: 10,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),

);

final textTheme = TextTheme(
 labelMedium: GoogleFonts.bangers(
     fontSize: 20,
     fontWeight: FontWeight.bold,
   color: Colors.black
 ),
  titleLarge: GoogleFonts.bangers(
      fontSize: 44,
      fontWeight: FontWeight.bold,
      color: Colors.white
  ),
  titleSmall: GoogleFonts.bangers(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white
  ),


);
