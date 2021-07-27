import 'package:bloc_test/bloc_test.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/events/todo_event.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/repositories/todo_repository.dart';
import 'package:exame_todo_list/features/screens/todo/todo_bloc.dart';
import 'package:exame_todo_list/features/state/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late TodoRepository repository;
  late TodoBloc bloc;

  setUp(() {
    repository = MockTodoRepository();
    bloc = TodoBloc(todoRepository: repository);
  });

  Todo mockWorkTodoModel = Todo(
    dateTime: DateTime.now(),
    itsDone: false,
    priority: TodoPriorityEnum.highPriority,
    category: TodoCategoryEnum.work,
    title: "mock",
  );

  group(
    "Todo bloc tests",
    () {
      group(
        "map to event methods",
        () {
          test(
            "Initial state is home state",
            () async {
              expect(bloc.state, TodoState());
            },
          );

          blocTest<TodoBloc, TodoState>(
            'emits [TodoTitleChanged] '
            'return state with new title',
            build: () => bloc,
            act: (bloc) => bloc.add(TodoTitleChanged(title: "mock")),
            expect: () => <TodoState>[
              TodoState(title: "mock", titleIsValid: true),
            ],
          );

          blocTest<TodoBloc, TodoState>(
            'emits [TodoTitleChanged] '
            'return state with titleIsValid false',
            build: () => bloc,
            act: (bloc) => bloc.add(TodoTitleChanged(title: "")),
            expect: () => <TodoState>[
              TodoState(title: "", titleIsValid: false),
            ],
          );

          blocTest<TodoBloc, TodoState>(
            'emits [TodoPriorityChanged] '
            'return state with priority',
            build: () => bloc,
            act: (bloc) => bloc.add(TodoPriorityChanged(priority: TodoPriorityEnum.highPriority)),
            expect: () => <TodoState>[
              TodoState(priority: TodoPriorityEnum.highPriority, priorityIsValid: true),
            ],
          );

          blocTest<TodoBloc, TodoState>(
            'emits [TodoCategoryChanged] '
            'return state with priority',
            build: () => bloc,
            act: (bloc) => bloc.add(TodoCategoryChanged(category: TodoCategoryEnum.work)),
            expect: () => <TodoState>[
              TodoState(category: TodoCategoryEnum.work),
            ],
          );

          blocTest<TodoBloc, TodoState>(
            'emits [TodoEditing] '
            'return state with priority',
            build: () => bloc,
            act: (bloc) => bloc.add(TodoEditing(
              todo: mockWorkTodoModel,
              dateController: TextEditingController(),
              titleController: TextEditingController(),
            )),
            expect: () => <TodoState>[
              TodoState(
                isEditing: true,
                title: mockWorkTodoModel.title,
                titleIsValid: true,
                priority: mockWorkTodoModel.priority,
                priorityIsValid: true,
                category: mockWorkTodoModel.category,
                dateTime: mockWorkTodoModel.dateTime,
              ),
            ],
          );
        },
      );
    },
  );
}
