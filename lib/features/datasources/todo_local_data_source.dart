import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/core/services/hive/hive_service.dart';
import 'package:exame_todo_list/features/models/todo.dart';

abstract class TodoLocalDataSource {
  Future<List<Todo>> getTaskList();
}

class TodoLocalDataSourceImplementation implements TodoLocalDataSource {
  final HiveService hive;
  TodoLocalDataSourceImplementation({required this.hive});

  @override
  Future<List<Todo>> getTaskList() async {
    try {
      final box = await hive.openBox(typeString: 'todo');

      List<Todo> todoList = box.values.toList() as List<Todo>;

      return todoList;
    } on LocalCacheException catch (e) {
      throw e;
    } on Exception catch (e) {
      throw e;
    }
  }
}
