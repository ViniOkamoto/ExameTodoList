import 'package:exame_todo_list/core/resources/constants.dart';
import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: TodoColors.highlightColor,
  backgroundColor: TodoColors.whiteColor,
  accentColor: TodoColors.highlightLightColor,
  unselectedWidgetColor: TodoColors.grayColor,
  fontFamily: Constants.fontFamily,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: TodoColors.darkColor,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return TodoColors.highlightLightColor; // Disabled color
          }
          return TodoColors.highlightColor; // Regular color
        },
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    ),
  ),
);
