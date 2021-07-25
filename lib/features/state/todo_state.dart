import 'package:equatable/equatable.dart';
import 'package:exame_todo_list/features/models/todo_model.dart';

class TodoState extends Equatable {
  final List<TodoModel>? todoList;
  final bool hasError;
  final bool isLoading;
  final Exception? exception;

  TodoState({
    this.todoList,
    this.hasError = false,
    this.isLoading = false,
    this.exception,
  });

  TodoState copyWith({
    List<TodoModel>? todoList,
    bool? hasError,
    bool? isLoading,
    Exception? exception,
  }) =>
      TodoState(
        todoList: todoList ?? this.todoList,
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        exception: exception ?? this.exception,
      );

  @override
  List<Object?> get props => [todoList, isLoading, hasError, exception];
}
