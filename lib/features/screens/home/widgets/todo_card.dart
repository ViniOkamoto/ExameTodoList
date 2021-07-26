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
  final Function(DismissDirection)? onDismissed;

  TodoCard({
    required this.todo,
    required this.onChanged,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.horizontal,
      key: UniqueKey(),
      background: _SwipeRight(),
      secondaryBackground: _SwipeLeft(),
      onDismissed: onDismissed,
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConverter.relativeHeight(16)),
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
                  Expanded(
                    child: Text(
                      todo.title,
                      style: TodoTypo.p2(color: TodoColors.darkerColor),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Spacing(width: 13),
                  Icon(
                    categoryIcons[todo.category],
                    size: SizeConverter.fontSize(24),
                    color: categoryColor[todo.category],
                  ),
                  Spacing(width: 4),
                  Text(
                    categoryName[todo.category]!,
                    style: TodoTypo.caption(color: TodoColors.darkColor),
                  )
                ],
              ),
              if (todo.dateTime != null) ...[
                Spacing(height: 16),
                Row(
                  children: [
                    Spacing(width: 13),
                    Icon(
                      Icons.calendar_today,
                      size: SizeConverter.fontSize(24),
                      color: TodoColors.lightColor,
                    ),
                    Spacing(width: 4),
                    Text(
                      DateHelper.formatDateToString(todo.dateTime!),
                      style: TodoTypo.caption(color: TodoColors.darkColor),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SwipeRight extends StatelessWidget {
  const _SwipeRight({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: SizeConverter.relativeWidth(16)),
      margin: EdgeInsets.only(
        left: SizeConverter.relativeWidth(16),
        bottom: SizeConverter.relativeHeight(16),
      ),
      decoration: BoxDecoration(
        color: TodoColors.highlightColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Icon(Icons.edit, color: Colors.white, size: SizeConverter.fontSize(24)),
    );
  }
}

class _SwipeLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: SizeConverter.relativeWidth(16)),
      margin: EdgeInsets.only(
        left: SizeConverter.relativeWidth(16),
        bottom: SizeConverter.relativeHeight(16),
      ),
      decoration: BoxDecoration(
        color: TodoColors.redPriorityColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Icon(Icons.delete, color: Colors.white, size: SizeConverter.fontSize(24)),
    );
  }
}
