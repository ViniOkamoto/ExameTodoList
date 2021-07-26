import 'package:exame_todo_list/features/events/home_event.dart';
import 'package:exame_todo_list/features/repositories/todo_repository.dart';
import 'package:exame_todo_list/features/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoRepository _repository;
  HomeBloc({required TodoRepository todoRepository})
      : this._repository = todoRepository,
        super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield state.copyWith(exception: null);
    if (event is FetchTaskList) {
      if (event.todoList.length != state.todoList.length) yield state.copyWith(todoList: event.todoList);
    }
    if (event is FilterList) {
      yield state.copyWith();
    } else if (event is TodoTouched) {
      final result = await _repository.updateTask(event.todo);
      yield state.copyWith(exception: result.exception);
    } else if (event is TodoDeleted) {
      final result = await _repository.deleteTask(event.todo);
      if (result.exception == null) state.todoList.remove(event.index);
      yield state.copyWith(exception: result.exception);
    }
  }
}
