import 'package:exame_todo_list/features/datasources/todo_local_data_source.dart';
import 'package:exame_todo_list/features/enums/priority_enum.dart';
import 'package:exame_todo_list/features/models/todo_model.dart';
import 'package:exame_todo_list/features/repositories/todo_repository.dart';
import 'package:exame_todo_list/features/state/todo_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todo_repository_test.mocks.dart';

@GenerateMocks([TodoLocalDataSource])
void main() {
  late TodoRepository repository;
  late TodoLocalDataSource localDataSource;

  setUp(() {
    localDataSource = MockTodoLocalDataSource();
    repository = TodoRepository(localSource: localDataSource);
  });

  TodoModel mockTodoModel = TodoModel(
    dateTime: DateTime.now(),
    isFinished: false,
    priority: TodoPriority.highPriority,
    title: "mock",
  );

  List<TodoModel> mockTaskList = [
    mockTodoModel,
    mockTodoModel,
    mockTodoModel,
  ];

  TodoState mockSuccessfulState = TodoState(
    todoList: [
      mockTodoModel,
      mockTodoModel,
      mockTodoModel,
    ],
  );

  TodoState mockSuccessfulStateWithEmptyList = TodoState(
    todoList: <TodoModel>[],
  );

  group(
    "Todo repository tests",
    () {
      test(
        "Should return TodoState without exception and returning from local source a task list",
        () async {
          when(localDataSource.getTasks()).thenAnswer(
            (_) async => mockTaskList,
          );

          final result = await repository.getTaskList();

          expect(result, mockSuccessfulState);
          verify(localDataSource.getTasks()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );
      //
      test(
        "Should return TodoState without exception and with task list empty",
        () async {
          when(localDataSource.getTasks()).thenAnswer(
            (_) async => <TodoModel>[],
          );

          final result = await repository.getTaskList();

          expect(result, mockSuccessfulStateWithEmptyList);
          verify(localDataSource.getTasks());
          verifyNoMoreInteractions(localDataSource);
        },
      );
      //
      // test(
      //   "When is an invalid password should return invalid password failure",
      //   () async {
      //     when(repository.authenticateUser(mockLoginRequest)).thenAnswer(
      //       (_) async => Left<Failure, AuthenticatedUserEntity>(InvalidPasswordFailure()),
      //     );
      //     final result = await usecase(mockLoginRequest);
      //
      //     expect(result, isA<Left<Failure, AuthenticatedUserEntity>>());
      //     verify(repository.authenticateUser(mockLoginRequest));
      //     verifyNoMoreInteractions(repository);
      //   },
      // );
    },
  );
}
