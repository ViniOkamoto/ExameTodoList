// Mocks generated by Mockito 5.0.12 from annotations
// in exame_todo_list/test/features/datasource/todo_local_data_source_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:exame_todo_list/core/services/hive/boxes.dart' as _i3;
import 'package:exame_todo_list/core/services/hive/hive_service.dart' as _i4;
import 'package:hive/hive.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeHiveInterface extends _i1.Fake implements _i2.HiveInterface {}

class _FakeBoxes extends _i1.Fake implements _i3.Boxes {}

class _FakeBox<E> extends _i1.Fake implements _i2.Box<E> {}

/// A class which mocks [HiveService].
///
/// See the documentation for Mockito's code generation for more information.
class MockHiveService extends _i1.Mock implements _i4.HiveService {
  MockHiveService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.HiveInterface get hive => (super.noSuchMethod(Invocation.getter(#hive),
      returnValue: _FakeHiveInterface()) as _i2.HiveInterface);
  @override
  _i3.Boxes get boxes =>
      (super.noSuchMethod(Invocation.getter(#boxes), returnValue: _FakeBoxes())
          as _i3.Boxes);
  @override
  _i5.Future<void> init() => (super.noSuchMethod(Invocation.method(#init, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<_i2.Box<dynamic>> getBox({String? typeString}) =>
      (super.noSuchMethod(
              Invocation.method(#getBox, [], {#typeString: typeString}),
              returnValue: Future<_i2.Box<dynamic>>.value(_FakeBox<dynamic>()))
          as _i5.Future<_i2.Box<dynamic>>);
}

/// A class which mocks [Box].
///
/// See the documentation for Mockito's code generation for more information.
class MockBox<E> extends _i1.Mock implements _i2.Box<E> {
  MockBox() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Iterable<E> get values =>
      (super.noSuchMethod(Invocation.getter(#values), returnValue: <E>[])
          as Iterable<E>);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  bool get isOpen =>
      (super.noSuchMethod(Invocation.getter(#isOpen), returnValue: false)
          as bool);
  @override
  bool get lazy =>
      (super.noSuchMethod(Invocation.getter(#lazy), returnValue: false)
          as bool);
  @override
  Iterable<dynamic> get keys =>
      (super.noSuchMethod(Invocation.getter(#keys), returnValue: <dynamic>[])
          as Iterable<dynamic>);
  @override
  int get length =>
      (super.noSuchMethod(Invocation.getter(#length), returnValue: 0) as int);
  @override
  bool get isEmpty =>
      (super.noSuchMethod(Invocation.getter(#isEmpty), returnValue: false)
          as bool);
  @override
  bool get isNotEmpty =>
      (super.noSuchMethod(Invocation.getter(#isNotEmpty), returnValue: false)
          as bool);
  @override
  Iterable<E> valuesBetween({dynamic startKey, dynamic endKey}) =>
      (super.noSuchMethod(
          Invocation.method(
              #valuesBetween, [], {#startKey: startKey, #endKey: endKey}),
          returnValue: <E>[]) as Iterable<E>);
  @override
  E? getAt(int? index) =>
      (super.noSuchMethod(Invocation.method(#getAt, [index])) as E?);
  @override
  Map<dynamic, E> toMap() => (super.noSuchMethod(Invocation.method(#toMap, []),
      returnValue: <dynamic, E>{}) as Map<dynamic, E>);
  @override
  dynamic keyAt(int? index) =>
      super.noSuchMethod(Invocation.method(#keyAt, [index]));
  @override
  _i5.Stream<_i2.BoxEvent> watch({dynamic key}) => (super.noSuchMethod(
      Invocation.method(#watch, [], {#key: key}),
      returnValue: Stream<_i2.BoxEvent>.empty()) as _i5.Stream<_i2.BoxEvent>);
  @override
  bool containsKey(dynamic key) =>
      (super.noSuchMethod(Invocation.method(#containsKey, [key]),
          returnValue: false) as bool);
  @override
  _i5.Future<void> put(dynamic key, E? value) =>
      (super.noSuchMethod(Invocation.method(#put, [key, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> putAt(int? index, E? value) =>
      (super.noSuchMethod(Invocation.method(#putAt, [index, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> putAll(Map<dynamic, E>? entries) =>
      (super.noSuchMethod(Invocation.method(#putAll, [entries]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<int> add(E? value) =>
      (super.noSuchMethod(Invocation.method(#add, [value]),
          returnValue: Future<int>.value(0)) as _i5.Future<int>);
  @override
  _i5.Future<Iterable<int>> addAll(Iterable<E>? values) =>
      (super.noSuchMethod(Invocation.method(#addAll, [values]),
              returnValue: Future<Iterable<int>>.value(<int>[]))
          as _i5.Future<Iterable<int>>);
  @override
  _i5.Future<void> delete(dynamic key) =>
      (super.noSuchMethod(Invocation.method(#delete, [key]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> deleteAt(int? index) =>
      (super.noSuchMethod(Invocation.method(#deleteAt, [index]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> deleteAll(Iterable<dynamic>? keys) =>
      (super.noSuchMethod(Invocation.method(#deleteAll, [keys]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> compact() =>
      (super.noSuchMethod(Invocation.method(#compact, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<int> clear() => (super.noSuchMethod(Invocation.method(#clear, []),
      returnValue: Future<int>.value(0)) as _i5.Future<int>);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<void> deleteFromDisk() =>
      (super.noSuchMethod(Invocation.method(#deleteFromDisk, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
}
