import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/core/services/hive/hive_service.dart';
import 'package:exame_todo_list/features/models/todo.dart';

abstract class TodoLocalDataSource {
  Future<List<Todo>> getTaskList();
  Future<void> createTask(Todo todo);
  Future<void> updateTask(Todo todo);
  Future<void> deleteTask(Todo todo);
}

class TodoLocalDataSourceImplementation implements TodoLocalDataSource {
  final HiveService hive;
  TodoLocalDataSourceImplementation({required this.hive});

  @override
  Future<List<Todo>> getTaskList() async {
    try {
      final box = await hive.getBox(typeString: 'todo');

      List<Todo> todoList = box.values.toList() as List<Todo>;

      return todoList;
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> deleteTask(Todo todo) async {
    try {
      await todo.delete();
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> createTask(Todo todo) async {
    try {
      final box = await hive.getBox(typeString: 'todo');

      box.add(todo);
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<void> updateTask(Todo todo) async {
    try {
      await todo.save();
    } on Exception catch (e) {
      throw e;
    }
  }
}
