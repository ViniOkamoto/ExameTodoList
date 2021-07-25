import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({
    required this.color,
    required this.onTap,
    required this.value,
    required this.size,
  });

  final bool value;
  final Color color;
  final Function() onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: SizeConverter.relativeWidth(size),
        height: SizeConverter.relativeWidth(size),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        child: Center(
          child: value
              ? Icon(
                  Icons.check,
                  size: size / 2,
                  color: Colors.white,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  size: size / 2,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
