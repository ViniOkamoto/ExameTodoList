import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/theme/typography.dart';
import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final double height;

  const SearchTextField({
    required this.hintText,
    required this.textEditingController,
    required this.onChanged,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConverter.relativeWidth(height),
      child: TextField(
        controller: textEditingController,
        onChanged: onChanged,
        style: TodoTypo.p3(color: TodoColors.darkestColor),
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 8, left: 0, right: 8, bottom: 8),
          filled: true,
          fillColor: TodoColors.whiteColor,
          isDense: true,
          hintText: hintText,
          hintStyle: TodoTypo.p3(color: TodoColors.grayColor),
          prefixIcon: Icon(
            Icons.search,
            color: TodoColors.grayColor,
            size: SizeConverter.fontSize(36),
          ),
          isCollapsed: true,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: TodoColors.lightColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: TodoColors.lightColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
