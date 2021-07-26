import 'package:equatable/equatable.dart';
import 'package:exame_todo_list/core/services/hive/hive_names_helper.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: HiveNamesHelper.todoBoxName)
class Todo with EquatableMixin, HiveObjectMixin {
  @HiveField(HiveNamesHelper.titleTodoField)
  late String title;
  @HiveField(HiveNamesHelper.dateTimeTodoField)
  late DateTime? dateTime;
  @HiveField(HiveNamesHelper.priorityTodoField)
  late TodoPriorityEnum priority;
  @HiveField(HiveNamesHelper.categoryTodoField)
  late TodoCategoryEnum category;
  @HiveField(HiveNamesHelper.itsDoneTodoField)
  late bool itsDone;

  Todo({
    required this.title,
    this.dateTime,
    required this.category,
    required this.priority,
    required this.itsDone,
  });

  Todo copyWith({
    String? title,
    DateTime? dateTime,
    TodoCategoryEnum? category,
    TodoPriorityEnum? priority,
    bool? itsDone,
  }) =>
      Todo(
        title: title ?? this.title,
        dateTime: dateTime ?? this.dateTime,
        category: category ?? this.category,
        priority: priority ?? this.priority,
        itsDone: itsDone ?? this.itsDone,
      );

  @override
  List<Object?> get props => [dateTime, category, itsDone, priority, title];
}
