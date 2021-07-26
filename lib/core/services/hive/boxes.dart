import 'package:exame_todo_list/core/services/hive/hive_names_helper.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:hive/hive.dart';

class Boxes {
  Box<Todo> getTaskList() => Hive.box<Todo>(HiveNamesHelper.todoDatabase);
}
