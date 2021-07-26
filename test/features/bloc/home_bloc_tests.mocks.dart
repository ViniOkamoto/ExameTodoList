// Mocks generated by Mockito 5.0.12 from annotations
// in exame_todo_list/test/features/bloc/home_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:exame_todo_list/features/models/todo.dart' as _i6;
import 'package:exame_todo_list/features/repositories/todo_repository.dart' as _i4;
import 'package:exame_todo_list/features/state/home_state.dart' as _i2;
import 'package:exame_todo_list/features/state/todo_state.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeHomeState extends _i1.Fake implements _i2.HomeState {}

class _FakeTodoState extends _i1.Fake implements _i3.TodoState {}

/// A class which mocks [TodoRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoRepository extends _i1.Mock implements _i4.TodoRepository {
  MockTodoRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.HomeState> getTaskList() => (super.noSuchMethod(Invocation.method(#getTaskList, []),
      returnValue: Future<_i2.HomeState>.value(_FakeHomeState())) as _i5.Future<_i2.HomeState>);
  @override
  _i5.Future<_i3.TodoState> createTask(_i6.Todo? todo) => (super.noSuchMethod(Invocation.method(#createTask, [todo]),
      returnValue: Future<_i3.TodoState>.value(_FakeTodoState())) as _i5.Future<_i3.TodoState>);
  @override
  _i5.Future<_i3.TodoState> updateTask(_i6.Todo? todo) => (super.noSuchMethod(Invocation.method(#updateTask, [todo]),
      returnValue: Future<_i3.TodoState>.value(_FakeTodoState())) as _i5.Future<_i3.TodoState>);
  @override
  _i5.Future<_i3.TodoState> deleteTask(_i6.Todo? todo) => (super.noSuchMethod(Invocation.method(#deleteTask, [todo]),
      returnValue: Future<_i3.TodoState>.value(_FakeTodoState())) as _i5.Future<_i3.TodoState>);
}
