import 'package:exame_todo_list/features/models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTasks();
}
