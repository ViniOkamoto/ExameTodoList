import 'package:equatable/equatable.dart';
import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/features/models/todo.dart';

class HomeState extends Equatable {
  final List<Todo> todoList;
  final bool hasError;
  final bool isLoading;
  final Failure? exception;

  HomeState({
    this.todoList = const [],
    this.hasError = false,
    this.isLoading = false,
    this.exception,
  });
  factory HomeState.loading() => HomeState(isLoading: true);

  factory HomeState.success({required List<Todo> todoList}) => HomeState(
        todoList: todoList,
      );

  factory HomeState.error({required Failure error}) => HomeState(hasError: true, exception: error);

  HomeState copyWith({
    List<Todo>? todoList,
    bool? hasError,
    bool? isLoading,
    Failure? exception,
  }) =>
      HomeState(
        todoList: todoList ?? this.todoList,
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        exception: exception ?? this.exception,
      );

  @override
  List<Object?> get props => [todoList, isLoading, hasError, exception];
}
