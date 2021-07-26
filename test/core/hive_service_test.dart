import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/core/services/hive/boxes.dart';
import 'package:exame_todo_list/core/services/hive/hive_names_helper.dart';
import 'package:exame_todo_list/core/services/hive/hive_service.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hive_service_test.mocks.dart';

@GenerateMocks([HiveInterface, Box, Boxes])
void main() {
  late HiveService service;
  late MockBox<Todo> mockBox;
  late MockHiveInterface mockHive;
  late MockBoxes boxes;

  setUp(() {
    mockHive = MockHiveInterface();
    mockBox = MockBox<Todo>();
    boxes = MockBoxes();
    service = HiveService(hive: mockHive, boxes: boxes);
  });

  group(
    "Hive service tests",
    () {
      test(
        "Should return hive box",
        () async {
          when(boxes.getTaskList()).thenAnswer(
            (_) => mockBox,
          );

          final result = await service.getBox(typeString: HiveNamesHelper.todoDatabase);

          expect(result, mockBox);
          verify(boxes.getTaskList());
          verifyNoMoreInteractions(boxes);
          verifyNoMoreInteractions(mockHive);
        },
      );

      test(
        "Should always throw LocalCacheException when get box throw error",
        () async {
          when(boxes.getTaskList()).thenThrow(Exception());

          final result = service.getBox(typeString: HiveNamesHelper.todoDatabase);

          expect(() => result, throwsA(isA<LocalCacheException>()));
          verify(boxes.getTaskList());
          verifyNoMoreInteractions(boxes);
          verifyNoMoreInteractions(mockHive);
        },
      );
    },
  );
}
