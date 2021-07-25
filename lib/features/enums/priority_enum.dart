import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:flutter/material.dart';

enum TodoPriority {
  highPriority,
  mediumPriority,
  lowPriority,
}

const Map<TodoPriority, Color> priorityColor = {
  TodoPriority.highPriority: TodoColors.redPriorityColor,
  TodoPriority.mediumPriority: TodoColors.yellowPriorityColor,
  TodoPriority.lowPriority: TodoColors.greenPriorityColor,
};