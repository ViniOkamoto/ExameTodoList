import 'package:equatable/equatable.dart';
import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/features/models/todo.dart';

class TodoState extends Equatable {
  final List<Todo>? todoList;
  final bool hasError;
  final bool isLoading;
  final Failure? exception;

  TodoState({
    this.todoList,
    this.hasError = false,
    this.isLoading = false,
    this.exception,
  });
  factory TodoState.loading() => TodoState(isLoading: true);

  factory TodoState.success({List<Todo>? todoList}) => TodoState(
        todoList: todoList,
      );

  factory TodoState.error({required Failure error}) => TodoState(hasError: true, exception: error);

  TodoState copyWith({
    List<Todo>? todoList,
    bool? hasError,
    bool? isLoading,
    Failure? exception,
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
