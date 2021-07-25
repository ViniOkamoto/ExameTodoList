import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TodoCategory {
  work,
  personal,
  wellness,
  other,
}

const Map<TodoCategory, IconData> categoryIcons = {
  TodoCategory.work: Icons.work,
  TodoCategory.personal: Icons.person,
  TodoCategory.wellness: Icons.spa,
  TodoCategory.other: Icons.done_all,
};

const Map<TodoCategory, Color> categoryColor = {
  TodoCategory.work: Color(0xFF720E07),
  TodoCategory.personal: Color(0xFF7765E3),
  TodoCategory.wellness: Color(0xFF65DEF1),
  TodoCategory.other: TodoColors.darkColor,
};

const Map<TodoCategory, Color> categoryShadow = {
  TodoCategory.work: Color(0x33720E07),
  TodoCategory.personal: Color(0x337765E3),
  TodoCategory.wellness: Color(0x3365DEF1),
  TodoCategory.other: Color(0x33697A8B),
};

const Map<TodoCategory, String> categoryName = {
  TodoCategory.work: "Trabalho",
  TodoCategory.personal: "Pessoal",
  TodoCategory.wellness: "Bem estar",
  TodoCategory.other: "Outros",
};
