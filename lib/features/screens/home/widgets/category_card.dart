import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/theme/typography.dart';
import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:exame_todo_list/features/enums/todo_category.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    required this.category,
    required this.onTap,
    required this.numberTasks,
  });

  final TodoCategory category;
  final Function() onTap;
  final int numberTasks;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: categoryShadow[category]!,
              blurRadius: 10,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: SizeConverter.relativeHeight(20),
              left: SizeConverter.relativeWidth(130),
              child: Opacity(
                opacity: 0.4,
                child: Icon(
                  categoryIcons[category],
                  color: categoryColor[category],
                  size: SizeConverter.fontSize(80),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConverter.relativeWidth(16),
                right: SizeConverter.relativeWidth(16),
                top: SizeConverter.relativeHeight(16),
                bottom: SizeConverter.relativeHeight(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$numberTasks tasks",
                    style: TodoTypo.p3(color: TodoColors.darkColor),
                  ),
                  Row(
                    children: [
                      Text(
                        categoryName[category]!,
                        style: TodoTypo.h2(color: TodoColors.darkestColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
