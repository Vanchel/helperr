import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart' as constants;

const _roundedBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(constants.borderRadius)),
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  textTheme: GoogleFonts.nunitoTextTheme(),
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
  toggleButtonsTheme: const ToggleButtonsThemeData(
    borderRadius: BorderRadius.all(Radius.circular(constants.borderRadius)),
  ),
  popupMenuTheme: const PopupMenuThemeData(shape: _roundedBorder),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.teal,
  textTheme: GoogleFonts.nunitoTextTheme(
    ThemeData(brightness: Brightness.dark).textTheme,
  ),
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
  toggleButtonsTheme: const ToggleButtonsThemeData(
    borderRadius: BorderRadius.all(Radius.circular(constants.borderRadius)),
  ),
  popupMenuTheme: const PopupMenuThemeData(shape: _roundedBorder),
);
