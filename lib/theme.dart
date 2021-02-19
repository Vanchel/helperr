import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _roundedBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(16.0)),
);

final theme = ThemeData(
  //textTheme: const GoogleFonts.nunitoTextTheme(),
  cardTheme: const CardTheme(shape: _roundedBorder),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(shape: _roundedBorder),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(shape: _roundedBorder),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(shape: _roundedBorder),
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: _roundedBorder,
  ),
);
