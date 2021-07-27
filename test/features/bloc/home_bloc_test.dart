import 'package:bloc_test/bloc_test.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/events/home_event.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/repositories/todo_repository.dart';
import 'package:exame_todo_list/features/screens/home/home_bloc.dart';
import 'package:exame_todo_list/features/state/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late TodoRepository repository;

  setUp(() {
    repository = MockTodoRepository();
  });

  Todo mockPersonalTodoModel = Todo(
    dateTime: DateTime.now(),
    itsDone: false,
    priority: TodoPriorityEnum.highPriority,
    category: TodoCategoryEnum.personal,
    title: "mock",
  );

  Todo mockWorkTodoModel = Todo(
    dateTime: DateTime.now(),
    itsDone: false,
    priority: TodoPriorityEnum.highPriority,
    category: TodoCategoryEnum.work,
    title: "mock",
  );

  Todo mockWellnessTodoModel = Todo(
    dateTime: DateTime.now(),
    itsDone: false,
    priority: TodoPriorityEnum.highPriority,
    category: TodoCategoryEnum.wellness,
    title: "mock",
  );
  Todo mockOtherTodoModel = Todo(
    dateTime: DateTime.now(),
    itsDone: false,
    priority: TodoPriorityEnum.highPriority,
    category: TodoCategoryEnum.other,
    title: "mock",
  );

  List<Todo> mockTaskList = [mockPersonalTodoModel, mockWorkTodoModel, mockWellnessTodoModel, mockOtherTodoModel];

  group(
    "Home bloc tests",
    () {
      group(
        "map to event methods",
        () {
          test(
            "Initial state is home state",
            () async {
              expect(HomeBloc(todoRepository: repository).state, HomeState());
            },
          );

          ///Todo: search how to fix when method behavior that doesn't creating mock value
          // blocTest<HomeBloc, HomeState>(
          //   'emits [TodoTouched] '
          //   'when todo is touched',
          //   build: () {
          //     when(
          //       repository.updateTask(mockPersonalTodoModel),
          //     ).thenAnswer((_) async => mockSuccessTodoState);
          //
          //     return HomeBloc(todoRepository: repository);
          //   },
          //   act: (bloc) {
          //     bloc.add(TodoTouched(todo: mockTodoModelTrueDone));
          //   },
          //   verify: (_) {
          //     verify(repository.updateTask(mockPersonalTodoModel));
          //   },
          //   expect: () => <HomeState>[HomeState()],
          // );

          blocTest<HomeBloc, HomeState>(
            'emits [FilterList] '
            'return state with category selected',
            build: () => HomeBloc(todoRepository: repository),
            act: (bloc) => bloc.add(FilterList(category: TodoCategoryEnum.work)),
            expect: () => <HomeState>[
              HomeState(),
              HomeState(categoryFilter: TodoCategoryEnum.work),
            ],
          );

          blocTest<HomeBloc, HomeState>(
            'emits [FetchTaskList] '
            'return state with category selected',
            build: () => HomeBloc(todoRepository: repository),
            act: (bloc) => bloc.add(FetchTaskList(todoList: mockTaskList)),
            expect: () => <HomeState>[
              HomeState(),
              HomeState(
                todoList: mockTaskList,
                workQuantity: 1,
                wellnessQuantity: 1,
                personalQuantity: 1,
                otherQuantity: 1,
              ),
            ],
          );

          ///Todo: search how to fix when method behavior that doesn't creating mock value
          // blocTest<HomeBloc, HomeState>(
          //   'emits [FetchTaskList] '
          //   'return without exception',
          //   build: () {
          //     when(
          //       repository.deleteTask(mockWorkTodoModel),
          //     ).thenThrow((Failure()));
          //
          //     return HomeBloc(todoRepository: repository);
          //   },
          //   act: (bloc) => bloc.add(TodoDeleted(todo: mockWorkTodoModel, index: 1)),
          //   expect: () => <HomeState>[
          //     HomeState(exception: Failure()),
          //   ],
          //   verify: (_) {
          //     verify(repository.deleteTask(mockWorkTodoModel)).called(1);
          //   },
          // );
        },
      );
    },
  );
}
