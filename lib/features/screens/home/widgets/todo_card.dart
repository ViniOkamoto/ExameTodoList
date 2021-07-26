import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/theme/typography.dart';
import 'package:exame_todo_list/core/utils/date_helper.dart';
import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/widgets/spacing.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final Function(bool?)? onChanged;

  TodoCard({
    required this.todo,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: priorityColor[todo.priority]!,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ), // BoxDecoration
      child: Container(
        margin: EdgeInsets.only(left: SizeConverter.relativeWidth(6)),
        padding: EdgeInsets.only(
          bottom: SizeConverter.relativeHeight(8),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  onChanged: onChanged,
                  value: todo.itsDone,
                  shape: CircleBorder(),
                  activeColor: TodoColors.highlightColor,
                ),
                Text(
                  todo.title,
                  style: TodoTypo.p2(color: TodoColors.darkerColor),
                )
              ],
            ),
            Row(
              children: [
                Spacing(width: 13),
                Icon(
                  categoryIcons[TodoCategoryEnum.work],
                  size: SizeConverter.fontSize(24),
                  color: TodoColors.lighterColor,
                ),
                Spacing(width: 4),
                Text(
                  categoryName[TodoCategoryEnum.work]!,
                  style: TodoTypo.caption(color: TodoColors.darkColor),
                )
              ],
            ),
            if (todo.dateTime != null)
              Row(
                children: [
                  Spacing(width: 13),
                  Icon(
                    Icons.calendar_today,
                    size: SizeConverter.fontSize(24),
                    color: TodoColors.lighterColor,
                  ),
                  Spacing(width: 4),
                  Text(
                    DateHelper.formatDateToString(todo.dateTime!),
                    style: TodoTypo.caption(color: TodoColors.darkColor),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
