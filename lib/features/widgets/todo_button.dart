import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/theme/typography.dart';
import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:flutter/material.dart';

class TodoPrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Widget? child;

  TodoPrimaryButton({
    this.onPressed,
    this.child,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConverter.relativeWidth(200),
      height: SizeConverter.relativeWidth(50),
      child: ElevatedButton(
        onPressed: onPressed,
        child: child != null
            ? child
            : Text(
                text,
                style: TodoTypo.p2(color: TodoColors.whiteColor),
              ),
      ),
    );
  }
}
