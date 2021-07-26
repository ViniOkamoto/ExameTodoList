import 'package:exame_todo_list/core/router/routes.dart';
import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/theme/typography.dart';
import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/screens/home/widgets/category_card.dart';
import 'package:exame_todo_list/features/screens/home/widgets/search_todo/search_text_field.dart';
import 'package:exame_todo_list/features/screens/home/widgets/todo_card.dart';
import 'package:exame_todo_list/features/widgets/spacing.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: SizeConverter.fontSize(24),
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.todo);
        },
      ),
      backgroundColor: TodoColors.lightestColor,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderPage(),
                  _CategoryList(),
                  Spacing(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConverter.relativeWidth(16),
                    ),
                    child: Text(
                      "TAREFAS",
                      style: TodoTypo.h3(color: TodoColors.grayColor),
                    ),
                  ),
                  Spacing(height: 16),
                  _TodoList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HeaderPage extends StatelessWidget {
  const _HeaderPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConverter.relativeWidth(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacing(height: 24),
          Text(
            "O que vamos fazer?",
            style: TodoTypo.h1(color: TodoColors.darkestColor),
          ),
          Spacing(height: 24),
          SearchTextField(
            hintText: "Digite o nome da tarefa",
            textEditingController: TextEditingController(),
            onChanged: (onChanged) {},
          ),
          Spacing(height: 24),
          Text(
            "CATEGORIAS",
            style: TodoTypo.h3(color: TodoColors.grayColor),
          ),
        ],
      ),
    );
  }
}

class _TodoList extends StatelessWidget {
  final List<Todo> todoList = [
    Todo(title: "Teste1", dateTime: DateTime.now(), itsDone: false, priority: TodoPriorityEnum.highPriority),
    Todo(title: "Teste2", itsDone: false, priority: TodoPriorityEnum.highPriority),
    Todo(title: "Teste3", itsDone: true, priority: TodoPriorityEnum.mediumPriority),
    Todo(title: "Teste4", itsDone: false, priority: TodoPriorityEnum.lowPriority),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConverter.relativeWidth(16),
        ),
        separatorBuilder: (context, index) {
          return Spacing(height: 8);
        },
        itemBuilder: (context, index) {
          return TodoCard(
            todo: todoList[index],
            onChanged: (bool) {},
          );
        },
        itemCount: todoList.length,
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final List<TodoCategoryEnum> categoryList = [
    TodoCategoryEnum.work,
    TodoCategoryEnum.personal,
    TodoCategoryEnum.wellness,
    TodoCategoryEnum.other,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConverter.relativeWidth(16),
          vertical: SizeConverter.relativeHeight(16),
        ),
        itemCount: categoryList.length,
        separatorBuilder: (context, index) {
          return Spacing(width: 24);
        },
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryCard(
            onTap: () {},
            category: categoryList[index],
            numberTasks: 30,
          );
        },
      ),
    );
  }
}
