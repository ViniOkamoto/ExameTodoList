import 'package:equatable/equatable.dart';
import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';

class TodoState extends Equatable {
  final String? title;
  final DateTime? dateTime;
  final TodoPriorityEnum? priority;
  final bool? isLoading;
  final bool hasError;
  final Failure? exception;

  TodoState({
    this.title = '',
    this.dateTime,
    this.priority = TodoPriorityEnum.lowPriority,
    this.isLoading = false,
    this.hasError = false,
    this.exception,
  });

  factory TodoState.loading() => TodoState(isLoading: true);

  factory TodoState.success() => TodoState();

  factory TodoState.error({required Failure error}) => TodoState(hasError: true, exception: error, isLoading: false);

  TodoState copyWith({
    String? title,
    DateTime? dateTime,
    TodoPriorityEnum? priority,
    bool? isLoading,
    bool? hasError,
    Failure? exception,
  }) =>
      TodoState(
        title: title ?? this.title,
        dateTime: dateTime ?? this.dateTime,
        priority: priority ?? this.priority,
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        exception: exception ?? this.exception,
      );

  @override
  List<Object?> get props => [title, dateTime, priority, isLoading, hasError, exception];
}
