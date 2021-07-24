import 'package:exame_todo_list/core/resources/constants.dart';
import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: Constants.fontFamily,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: PubliColors.darkColor,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return PubliColors.highlightLightColor; // Disabled color
          }
          return PubliColors.highlightColor; // Regular color
        },
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    ),
  ),
);
