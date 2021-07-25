import 'package:equatable/equatable.dart';
import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/features/enums/priority_enum.dart';

class TodoCreationState extends Equatable {
  final String? title;
  final DateTime? dateTime;
  final TodoPriority? priority;
  final bool? isLoading;
  final bool hasError;
  final Failure? exception;

  TodoCreationState({
    this.title = '',
    this.dateTime,
    this.priority = TodoPriority.lowPriority,
    this.isLoading = false,
    this.hasError = false,
    this.exception,
  });

  factory TodoCreationState.loading() => TodoCreationState(isLoading: true);

  factory TodoCreationState.success() => TodoCreationState();

  factory TodoCreationState.error({required Failure error}) =>
      TodoCreationState(hasError: true, exception: error, isLoading: false);

  TodoCreationState copyWith({
    String? title,
    DateTime? dateTime,
    TodoPriority? priority,
    bool? isLoading,
    bool? hasError,
    Failure? exception,
  }) =>
      TodoCreationState(
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
