import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TodoCategoryEnum {
  work,
  personal,
  wellness,
  other,
}

const List<TodoCategoryEnum> categoryList = [
  TodoCategoryEnum.work,
  TodoCategoryEnum.personal,
  TodoCategoryEnum.wellness,
  TodoCategoryEnum.other,
];
const Map<TodoCategoryEnum, IconData> categoryIcons = {
  TodoCategoryEnum.work: Icons.work,
  TodoCategoryEnum.personal: Icons.person,
  TodoCategoryEnum.wellness: Icons.spa,
  TodoCategoryEnum.other: Icons.done_all,
};

const Map<TodoCategoryEnum, Color> categoryColor = {
  TodoCategoryEnum.work: Color(0xFF720E07),
  TodoCategoryEnum.personal: Color(0xFF7765E3),
  TodoCategoryEnum.wellness: Color(0xFF65DEF1),
  TodoCategoryEnum.other: TodoColors.darkColor,
};

const Map<TodoCategoryEnum, Color> categoryShadow = {
  TodoCategoryEnum.work: Color(0x33720E07),
  TodoCategoryEnum.personal: Color(0x337765E3),
  TodoCategoryEnum.wellness: Color(0x3365DEF1),
  TodoCategoryEnum.other: Color(0x33697A8B),
};

const Map<TodoCategoryEnum, String> categoryName = {
  TodoCategoryEnum.work: "Trabalho",
  TodoCategoryEnum.personal: "Pessoal",
  TodoCategoryEnum.wellness: "Bem estar",
  TodoCategoryEnum.other: "Outros",
};
