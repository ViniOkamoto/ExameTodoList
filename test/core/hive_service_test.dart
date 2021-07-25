import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/core/services/hive/hive_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hive_service_test.mocks.dart';

@GenerateMocks([HiveInterface, Box])
void main() {
  late HiveService service;
  late MockBox mockBox;
  late MockHiveInterface mockHive;

  setUp(() {
    mockHive = MockHiveInterface();
    mockBox = MockBox();
    service = HiveService(hive: mockHive);
  });

  group(
    "Hive service tests",
    () {
      test(
        "Should open and return hive box",
        () async {
          when(mockHive.openBox(any)).thenAnswer(
            (_) async => mockBox,
          );

          final result = await service.openBox(typeString: "typeString");

          expect(result, mockBox);
          verify(mockHive.openBox(any));
          verifyNoMoreInteractions(mockHive);
        },
      );

      test(
        "Should always throw LocalCacheException when try to open hive box",
        () async {
          when(mockHive.openBox(any)).thenThrow(Exception());

          final result = service.openBox(typeString: "typeString");

          expect(() => result, throwsA(isA<LocalCacheException>()));
          verify(mockHive.openBox(any));
          verifyNoMoreInteractions(mockHive);
        },
      );
    },
  );
}
