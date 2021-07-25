import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/features/datasources/todo_local_data_source.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/state/todo_creation_state.dart';
import 'package:exame_todo_list/features/state/todo_state.dart';

class TodoRepository {
  final TodoLocalDataSource localSource;
  TodoRepository({required this.localSource});

  Future<TodoState> getTaskList() async {
    try {
      return TodoState.success(todoList: await localSource.getTaskList());
    } on LocalFailure catch (e) {
      return TodoState.error(error: e);
    } on Exception {
      return TodoState.error(error: Failure());
    }
  }

  Future<TodoCreationState> createTask(Todo todo) async {
    try {
      await localSource.createTask(todo);
      return TodoCreationState.success();
    } on LocalFailure catch (e) {
      return TodoCreationState.error(error: e);
    } on Exception {
      return TodoCreationState.error(error: Failure());
    }
  }

  Future<TodoCreationState> updateTask(Todo todo) async {
    try {
      await localSource.updateTask(todo);
      return TodoCreationState.success();
    } on Exception {
      return TodoCreationState.error(error: Failure());
    }
  }

  Future<TodoCreationState> deleteTask(Todo todo) async {
    try {
      await localSource.deleteTask(todo);
      return TodoCreationState.success();
    } on Exception {
      return TodoCreationState.error(error: Failure());
    }
  }
}
