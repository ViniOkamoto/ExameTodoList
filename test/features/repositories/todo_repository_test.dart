import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/features/datasources/todo_local_data_source.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/repositories/todo_repository.dart';
import 'package:exame_todo_list/features/state/todo_creation_state.dart';
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

  Todo mockTodoModel = Todo(
    dateTime: DateTime.now(),
    itsDone: false,
    priority: TodoPriorityEnum.highPriority,
    title: "mock",
  );

  List<Todo> mockTaskList = [
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

  TodoState mockLocalErrorState = TodoState(
    exception: LocalFailure(errorText: "local error"),
    hasError: true,
  );

  TodoState mockAnyErrorState = TodoState(
    exception: Failure(),
    hasError: true,
  );

  TodoState mockSuccessfulStateWithEmptyList = TodoState(
    todoList: <Todo>[],
  );

  group(
    "Todo repository tests",
    () {
      group("get methods", () {
        test(
          "Should return TodoState without exception and returning from local source a task list",
          () async {
            when(localDataSource.getTaskList()).thenAnswer(
              (_) async => mockTaskList,
            );

            final result = await repository.getTaskList();

            expect(result, mockSuccessfulState);
            verify(localDataSource.getTaskList()).called(1);
            verifyNoMoreInteractions(localDataSource);
          },
        );

        test(
          "Should return TodoState without exception and with task list empty",
          () async {
            when(localDataSource.getTaskList()).thenAnswer(
              (_) async => <Todo>[],
            );

            final result = await repository.getTaskList();

            expect(result, mockSuccessfulStateWithEmptyList);
            verify(localDataSource.getTaskList());
            verifyNoMoreInteractions(localDataSource);
          },
        );

        test(
          "Should return TodoState with local exception from external source and return a LocalFailure exception inside the state",
          () async {
            when(localDataSource.getTaskList()).thenThrow(LocalFailure(errorText: "local error"));

            final result = await repository.getTaskList();

            expect(result, mockLocalErrorState);
            verify(localDataSource.getTaskList());
            verifyNoMoreInteractions(localDataSource);
          },
        );

        test(
          "Should return TodoState with any exception and return a Failure exception inside the state",
          () async {
            when(localDataSource.getTaskList()).thenThrow(Exception());

            final result = await repository.getTaskList();

            expect(result, mockAnyErrorState);
            verify(localDataSource.getTaskList());
            verifyNoMoreInteractions(localDataSource);
          },
        );
      });

      group(
        "create scenarios",
        () {
          test(
            "Should return TodoCreation without exception and verify methods for creating todo",
            () async {
              final result = await repository.createTask(mockTodoModel);

              expect(result, TodoCreationState.success());
              verify(localDataSource.createTask(mockTodoModel));
              verifyNoMoreInteractions(localDataSource);
            },
          );

          test(
            "Should return TodoCreation with Failure exception",
            () async {
              when(localDataSource.createTask(mockTodoModel)).thenThrow(Exception());
              final result = await repository.createTask(mockTodoModel);

              expect(result, TodoCreationState.error(error: Failure()));
              verify(localDataSource.createTask(mockTodoModel));
              verifyNoMoreInteractions(localDataSource);
            },
          );

          test(
            "Should return TodoCreation with LocalFailure exception",
            () async {
              when(localDataSource.createTask(mockTodoModel)).thenThrow(LocalFailure(errorText: "erro"));
              final result = await repository.createTask(mockTodoModel);

              expect(result, TodoCreationState.error(error: LocalFailure(errorText: "erro")));
              verify(localDataSource.createTask(mockTodoModel));
              verifyNoMoreInteractions(localDataSource);
            },
          );
        },
      );

      group(
        "delete scenarios",
        () {
          test(
            "Should return TodoCreation without exception and verify methods for deleting todo",
            () async {
              final result = await repository.deleteTask(mockTodoModel);

              expect(result, TodoCreationState.success());
              verify(localDataSource.deleteTask(mockTodoModel));
              verifyNoMoreInteractions(localDataSource);
            },
          );

          test(
            "Should return TodoCreation with Failure exception",
            () async {
              when(localDataSource.deleteTask(mockTodoModel)).thenThrow(Exception());
              final result = await repository.deleteTask(mockTodoModel);

              expect(result, TodoCreationState.error(error: Failure()));
              verify(localDataSource.deleteTask(mockTodoModel));
              verifyNoMoreInteractions(localDataSource);
            },
          );
        },
      );

      group(
        "update scenarios",
        () {
          test(
            "Should return TodoCreation without exception and verify methods for updating todo",
            () async {
              final result = await repository.updateTask(mockTodoModel);

              expect(result, TodoCreationState.success());
              verify(localDataSource.updateTask(mockTodoModel));
              verifyNoMoreInteractions(localDataSource);
            },
          );

          test(
            "Should return TodoCreation with Failure exception",
            () async {
              when(localDataSource.updateTask(mockTodoModel)).thenThrow(Exception());
              final result = await repository.updateTask(mockTodoModel);

              expect(result, TodoCreationState.error(error: Failure()));
              verify(localDataSource.updateTask(mockTodoModel));
              verifyNoMoreInteractions(localDataSource);
            },
          );
        },
      );
    },
  );
}
