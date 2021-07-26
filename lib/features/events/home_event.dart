import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/models/todo.dart';

abstract class HomeEvent {}

class TodoTouched extends HomeEvent {
  final Todo todo;

  TodoTouched({required this.todo});
}

class FilterList extends HomeEvent {
  final TodoCategoryEnum category;

  FilterList({required this.category});
}

class TodoDeleted extends HomeEvent {
  final Todo todo;
  final int index;

  TodoDeleted({required this.todo, required this.index});
}

class FetchTaskList extends HomeEvent {
  final List<Todo> todoList;
  FetchTaskList({required this.todoList});
}
