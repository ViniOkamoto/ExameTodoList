import 'package:equatable/equatable.dart';
import 'package:exame_todo_list/features/enums/priority_enum.dart';

class TodoModel extends Equatable {
  final DateTime dateTime;
  final bool isFinished;
  final TodoPriority priority;
  final String title;

  TodoModel({
    required this.dateTime,
    required this.isFinished,
    required this.priority,
    required this.title,
  });

  @override
  List<Object?> get props => [dateTime, isFinished, priority, title];
}
