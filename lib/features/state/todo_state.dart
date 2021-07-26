import 'package:equatable/equatable.dart';
import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/core/utils/form_status.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';

class TodoState extends Equatable {
  final String? title;
  final bool titleIsValid;
  final DateTime? dateTime;
  final TodoPriorityEnum? priority;
  final bool priorityIsValid;
  final TodoCategoryEnum? category;
  final Failure? exception;
  final FormStatus formStatus;
  final bool isEditing;

  bool get isValidForm {
    return titleIsValid && priorityIsValid;
  }

  TodoState({
    this.title,
    this.titleIsValid = false,
    this.dateTime,
    this.priority,
    this.category = TodoCategoryEnum.other,
    this.priorityIsValid = false,
    this.isEditing = false,
    this.exception,
    this.formStatus = const InitialFormStatus(),
  });

  factory TodoState.success() => TodoState();

  factory TodoState.error({required Failure error}) => TodoState(exception: error);

  TodoState copyWith({
    String? title,
    bool? titleIsValid,
    DateTime? dateTime,
    bool? priorityIsValid,
    TodoPriorityEnum? priority,
    TodoCategoryEnum? category,
    Failure? exception,
    FormStatus? formStatus,
    bool? isEditing,
  }) =>
      TodoState(
        title: title ?? this.title,
        titleIsValid: titleIsValid ?? this.titleIsValid,
        dateTime: dateTime ?? this.dateTime,
        priority: priority ?? this.priority,
        priorityIsValid: priorityIsValid ?? this.priorityIsValid,
        category: category ?? this.category,
        formStatus: formStatus ?? this.formStatus,
        exception: exception ?? this.exception,
        isEditing: isEditing ?? this.isEditing,
      );

  @override
  List<Object?> get props => [
        title,
        dateTime,
        priority,
        exception,
        formStatus,
        category,
        priorityIsValid,
        titleIsValid,
      ];
}
