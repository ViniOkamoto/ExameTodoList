import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:flutter/material.dart';

class DropDownTextField extends StatelessWidget {
  final Function(dynamic) onChanged;
  final dynamic value;
  final String hintText;
  final List<DropdownMenuItem<Object?>> items;

  DropDownTextField({
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      elevation: 0,
      items: items,
      onChanged: onChanged,
      value: value,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: TodoColors.lighterColor, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: SizeConverter.relativeHeight(16),
          horizontal: SizeConverter.relativeWidth(16),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: TodoColors.lighterColor, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        hintText: hintText,
        errorText: null,
      ),
    );
  }
}
