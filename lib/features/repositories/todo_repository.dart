import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/features/datasources/todo_local_data_source.dart';
import 'package:exame_todo_list/features/state/todo_state.dart';

class TodoRepository {
  final TodoLocalDataSource localSource;
  TodoRepository({required this.localSource});

  Future<TodoState> getTaskList() async {
    try {
      return TodoState.success(todoList: await localSource.getTaskList());
    } on LocalCacheException catch (e) {
      return TodoState.error(error: LocalFailure(errorText: e.errorText));
    } on Exception {
      return TodoState.error(error: Failure());
    }
  }
}
