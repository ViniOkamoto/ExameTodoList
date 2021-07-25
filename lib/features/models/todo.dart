import 'package:equatable/equatable.dart';
import 'package:exame_todo_list/core/services/hive/hive_names_helper.dart';
import 'package:exame_todo_list/features/enums/priority_enum.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: HiveNamesHelper.todoBoxName)
class Todo with EquatableMixin, HiveObjectMixin {
  @HiveField(HiveNamesHelper.titleTodoField)
  final String title;
  @HiveField(HiveNamesHelper.dateTimeTodoField)
  final DateTime dateTime;
  @HiveField(HiveNamesHelper.priorityTodoField)
  final TodoPriority priority;
  @HiveField(HiveNamesHelper.itsDoneTodoField)
  final bool itsDone;

  Todo({
    required this.title,
    required this.dateTime,
    required this.priority,
    required this.itsDone,
  });

  @override
  List<Object?> get props => [dateTime, itsDone, priority, title];
}
