import 'package:exame_todo_list/features/datasources/todo_local_data_source.dart';
import 'package:exame_todo_list/features/state/todo_state.dart';

class TodoRepository {
  final TodoLocalDataSource localSource;
  TodoRepository({required this.localSource});

  Future<TodoState> getTaskList() async {
    try {
      return TodoState(todoList: await localSource.getTasks(), isLoading: false);
    } on Exception catch (e) {
      return TodoState(exception: e, isLoading: false);
    }
  }
}
