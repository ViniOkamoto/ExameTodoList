import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:flutter/material.dart';

enum TodoPriorityEnum {
  highPriority,
  mediumPriority,
  lowPriority,
}

const List<TodoPriorityEnum> priorityList = [
  TodoPriorityEnum.highPriority,
  TodoPriorityEnum.mediumPriority,
  TodoPriorityEnum.lowPriority,
];

const Map<TodoPriorityEnum, Color> priorityColor = {
  TodoPriorityEnum.highPriority: TodoColors.redPriorityColor,
  TodoPriorityEnum.mediumPriority: TodoColors.yellowPriorityColor,
  TodoPriorityEnum.lowPriority: TodoColors.greenPriorityColor,
};

const Map<TodoPriorityEnum, String> priorityName = {
  TodoPriorityEnum.highPriority: "Alta",
  TodoPriorityEnum.mediumPriority: "Média",
  TodoPriorityEnum.lowPriority: "Baixa",
};
