import 'package:exame_todo_list/core/utils/form_status.dart';
import 'package:exame_todo_list/features/events/todo_event.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/repositories/todo_repository.dart';
import 'package:exame_todo_list/features/state/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;
  TodoBloc({required TodoRepository todoRepository})
      : this._repository = todoRepository,
        super(TodoState());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoTitleChanged) {
      yield state.copyWith(title: event.title, titleIsValid: _checkTitleIsValid(event.title));
    } else if (event is TodoCategoryChanged) {
      yield state.copyWith(category: event.category);
    } else if (event is TodoPriorityChanged) {
      yield state.copyWith(priority: event.priority, priorityIsValid: true);
    } else if (event is TodoDateChanged) {
      yield state.copyWith(dateTime: event.date);
    } else if (event is TodoSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting(), exception: null);

      final result = await _repository.createTask(
        Todo(
          title: state.title!,
          category: state.category!,
          dateTime: state.dateTime,
          priority: state.priority!,
          itsDone: false,
        ),
      );
      yield state.copyWith(
        formStatus: result.exception != null ? InitialFormStatus() : SubmissionSuccess(),
        exception: result.exception,
      );
    }
  }

  _checkTitleIsValid(String title) {
    return title.isNotEmpty;
  }
}
