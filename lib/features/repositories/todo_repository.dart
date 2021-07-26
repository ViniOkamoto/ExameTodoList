import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/features/datasources/todo_local_data_source.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/state/home_state.dart';
import 'package:exame_todo_list/features/state/todo_state.dart';

abstract class TodoRepository {
  Future<HomeState> getTaskList();
  Future<TodoState> createTask(Todo todo);
  Future<TodoState> updateTask(Todo todo);
  Future<TodoState> deleteTask(Todo todo);
}

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localSource;
  TodoRepositoryImpl({required this.localSource});

  Future<HomeState> getTaskList() async {
    try {
      return HomeState.success(todoList: await localSource.getTaskList());
    } on LocalFailure catch (e) {
      return HomeState.error(error: e);
    } on Exception {
      return HomeState.error(error: Failure(errorText: "Erro ao buscar lista"));
    }
  }

  Future<TodoState> createTask(Todo todo) async {
    try {
      await localSource.createTask(todo);
      return TodoState.success();
    } on LocalFailure catch (e) {
      return TodoState.error(error: e);
    } on Exception {
      return TodoState.error(error: Failure(errorText: "Erro ao criar tarefa"));
    }
  }

  Future<TodoState> updateTask(Todo todo) async {
    try {
      await localSource.updateTask(todo);
      return TodoState.success();
    } catch (e) {
      return TodoState.error(error: Failure());
    }
  }

  Future<TodoState> deleteTask(Todo todo) async {
    try {
      await localSource.deleteTask(todo);
      return TodoState.success();
    } catch (e) {
      return TodoState.error(error: Failure(errorText: "Erro ao deletar tarefa"));
    }
  }
}
