import 'package:dartx/dartx.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/events/home_event.dart';
import 'package:exame_todo_list/features/models/todo.dart';
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
      yield state.copyWith(
        todoList: event.todoList,
        workQuantity: _returnCategoryQuantity(TodoCategoryEnum.work, event.todoList),
        wellnessQuantity: _returnCategoryQuantity(TodoCategoryEnum.wellness, event.todoList),
        personalQuantity: _returnCategoryQuantity(TodoCategoryEnum.personal, event.todoList),
        otherQuantity: _returnCategoryQuantity(TodoCategoryEnum.other, event.todoList),
      );
    } else if (event is FilterList) {
      yield state.copyWith(categoryFilter: event.category);
    } else if (event is TodoTouched) {
      final result = await _repository.updateTask(event.todo);
      yield state.copyWith(exception: result.exception);
    } else if (event is TodoDeleted) {
      final result = await _repository.deleteTask(event.todo);
      if (result.exception == null) state.todoList.remove(event.index);
      yield state.copyWith(exception: result.exception);
    }
  }

  int _returnCategoryQuantity(TodoCategoryEnum category, List<Todo> list) {
    var quantity = list.count((e) => e.category.index == categoryIndex[category]);
    return quantity;
  }
}
