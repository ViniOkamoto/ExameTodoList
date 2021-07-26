import 'dart:io';

import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class HiveService {
  final HiveInterface hive;
  HiveService({required this.hive});

  Future<void> init() async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    hive
      ..init(directory.path)
      ..registerAdapter(TodoPriorityEnumAdapter())
      ..registerAdapter(TodoCategoryEnumAdapter())
      ..registerAdapter(TodoAdapter());
  }

  Future<Box> openBox({required String typeString}) async {
    try {
      final box = await hive.openBox(typeString);
      return box;
    } catch (e) {
      throw LocalCacheException(errorText: "Erro ao buscar dados");
    }
  }
}
