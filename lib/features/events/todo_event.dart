import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:flutter/cupertino.dart';

abstract class TodoEvent {}

class TodoTitleChanged extends TodoEvent {
  final String title;

  TodoTitleChanged({required this.title});
}

class TodoPriorityChanged extends TodoEvent {
  final TodoPriorityEnum priority;

  TodoPriorityChanged({required this.priority});
}

class TodoCategoryChanged extends TodoEvent {
  final TodoCategoryEnum category;

  TodoCategoryChanged({required this.category});
}

class TodoDateChanged extends TodoEvent {
  final DateTime date;

  TodoDateChanged({required this.date});
}

class TodoSubmitted extends TodoEvent {
  final Todo? todo;
  TodoSubmitted({this.todo});
}

class TodoEditing extends TodoEvent {
  final Todo todo;
  final TextEditingController dateController;
  final TextEditingController titleController;

  TodoEditing({
    required this.todo,
    required this.titleController,
    required this.dateController,
  });
}
