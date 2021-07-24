import 'package:exame_todo_list/core/resources/constants.dart';
import 'package:flutter/material.dart';

class SizeConverter {
  static double factorWidth(double size) {
    double xdWidth = 375.0; // Figma layout width
    return (size * 100 / xdWidth) / 100;
  }

  static double factorHeight(double size) {
    double xdHeight = 812.0; // Figma layout height
    return (size * 100 / xdHeight) / 100;
  }

  static double relativeWidth(double size) {
    return MediaQuery.of(Constants.appGlobalKey.currentContext!).size.width * factorWidth(size);
  }

  static double relativeHeight(double size) {
    return MediaQuery.of(Constants.appGlobalKey.currentContext!).size.height * factorHeight(size);
  }

  static fontSize(double fontSize) {
    return MediaQuery.of(Constants.appGlobalKey.currentContext!).size.width * SizeConverter.factorWidth(fontSize);
  }
}
