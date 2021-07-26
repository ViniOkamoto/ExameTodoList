import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:flutter/material.dart';

class TodoTypo {
  static TextStyle h1({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(32),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle h2({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(21),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle h3({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      letterSpacing: 0.3,
      fontSize: SizeConverter.fontSize(14),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle h4({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(14),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle p1({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(24),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle p2({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(16),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle p3({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(14),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle caption({
    color = Colors.black,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(13),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle smallText({
    color = Colors.black,
    fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      fontSize: SizeConverter.fontSize(10),
      fontWeight: fontWeight,
    );
  }
}
