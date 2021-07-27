import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TodoTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? textEditingController;
  final Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;

  TodoTextField({
    Key? key,
    required this.hintText,
    this.textEditingController,
    required this.onChanged,
    this.inputFormatters,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.done,
      maxLines: 3,
      textAlign: TextAlign.center,
      style: TodoTypo.p1(color: TodoColors.darkestColor),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        isDense: false,
        hintText: hintText,
        hintStyle: TodoTypo.p1(color: TodoColors.darkColor),
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        errorStyle: TodoTypo.p3(
          color: TodoColors.redPriorityColor,
        ),
      ),
    );
  }
}
