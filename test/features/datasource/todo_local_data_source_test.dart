import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/core/services/hive/hive_service.dart';
import 'package:exame_todo_list/features/datasources/todo_local_data_source.dart';
import 'package:exame_todo_list/features/enums/priority_enum.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todo_local_data_source_test.mocks.dart';

@GenerateMocks([HiveService, Box])
void main() {
  late TodoLocalDataSourceImplementation localDataSource;
  late MockHiveService mockHive;
  late MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    mockHive = MockHiveService();
    localDataSource = TodoLocalDataSourceImplementation(hive: mockHive);
  });

  Todo mockTodoModel = Todo(
    dateTime: DateTime.now(),
    itsDone: false,
    priority: TodoPriority.highPriority,
    title: "mock",
  );

  List<Todo> mockTaskList = [
    mockTodoModel,
    mockTodoModel,
    mockTodoModel,
  ];

  group(
    "Todo repository tests",
    () {
      test(
        "Should open and return hive box and return a task list with 3 elements",
        () async {
          when(mockHive.openBox(typeString: "todo")).thenAnswer(
            (_) async => mockBox,
          );
          when(mockBox.values.toList()).thenAnswer(
            (_) => mockTaskList,
          );

          final result = await localDataSource.getTaskList();

          expect(result.length, 3);
          verify(mockHive.openBox(typeString: "todo")).called(1);
          verify(mockBox.values).called(1);
          verifyNoMoreInteractions(mockBox);
          verifyNoMoreInteractions(mockHive);
        },
      );

      test(
        "Should open and return hive box and return a empty task list",
        () async {
          when(mockHive.openBox(typeString: "todo")).thenAnswer(
            (_) async => mockBox,
          );
          when(mockBox.values.toList()).thenAnswer(
            (_) => <Todo>[],
          );

          final result = await localDataSource.getTaskList();

          expect(result.length, 0);
          verify(mockHive.openBox(typeString: "todo")).called(1);
          verify(mockBox.values.toList()).called(1);
          verifyNoMoreInteractions(mockBox);
          verifyNoMoreInteractions(mockHive);
        },
      );

      test(
        "Should throw LocalCacheException when don't found hive box",
        () async {
          when(mockHive.openBox(typeString: "todo")).thenThrow(LocalCacheException(errorText: "Erro cache"));
          final result = localDataSource.getTaskList();

          expect(() => result, throwsA(isA<LocalCacheException>()));
          verify(mockHive.openBox(typeString: "todo")).called(1);
          verifyNever(mockBox.values);
          verifyNoMoreInteractions(mockBox);
          verifyNoMoreInteractions(mockHive);
        },
      );

      test(
        "Should capture any exception when try to get list",
        () async {
          when(mockHive.openBox(typeString: "todo")).thenAnswer(
            (_) async => mockBox,
          );

          when(mockBox.values.toList()).thenThrow(Exception());
          final result = localDataSource.getTaskList();

          expect(() => result, throwsA(isA<Exception>()));
          verify(mockHive.openBox(typeString: "todo")).called(1);
          verifyNoMoreInteractions(mockBox);
          verifyNoMoreInteractions(mockHive);
        },
      );
    },
  );
}
