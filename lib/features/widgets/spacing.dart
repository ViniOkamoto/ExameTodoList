import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  final double width;
  final double height;
  const Spacing({this.width = 0, this.height = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConverter.relativeWidth(width),
      height: SizeConverter.relativeHeight(height),
    );
  }
}
