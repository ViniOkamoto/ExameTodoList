import 'package:equatable/equatable.dart';
import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/models/todo.dart';

class HomeState extends Equatable {
  final List<Todo> todoList;
  final bool hasError;
  final bool isLoading;
  final Failure? exception;
  final int? workQuantity;
  final int? personalQuantity;
  final int? wellnessQuantity;
  final int? otherQuantity;
  final TodoCategoryEnum? categoryFilter;

  HomeState({
    this.todoList = const [],
    this.hasError = false,
    this.isLoading = false,
    this.exception,
    this.otherQuantity,
    this.personalQuantity,
    this.wellnessQuantity,
    this.workQuantity,
    this.categoryFilter,
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
    int? workQuantity,
    int? personalQuantity,
    int? wellnessQuantity,
    int? otherQuantity,
    TodoCategoryEnum? categoryFilter,
  }) =>
      HomeState(
        todoList: todoList ?? this.todoList,
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        exception: exception ?? this.exception,
        categoryFilter: categoryFilter == this.categoryFilter ? null : categoryFilter ?? this.categoryFilter,
        workQuantity: workQuantity ?? this.workQuantity,
        personalQuantity: personalQuantity ?? this.personalQuantity,
        wellnessQuantity: wellnessQuantity ?? this.wellnessQuantity,
        otherQuantity: otherQuantity ?? this.otherQuantity,
      );

  @override
  List<Object?> get props => [
        todoList,
        hasError,
        isLoading,
        exception,
        workQuantity,
        personalQuantity,
        wellnessQuantity,
        otherQuantity,
        categoryFilter
      ];
}
