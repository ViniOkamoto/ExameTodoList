import 'dart:io';

import 'package:exame_todo_list/core/errors/common_exceptions.dart';
import 'package:exame_todo_list/core/services/hive/boxes.dart';
import 'package:exame_todo_list/core/services/hive/hive_names_helper.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class HiveService {
  final HiveInterface hive;
  final Boxes boxes;
  HiveService({required this.hive, required this.boxes});

  Future<void> init() async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    hive
      ..init(directory.path)
      ..registerAdapter(TodoPriorityEnumAdapter())
      ..registerAdapter(TodoCategoryEnumAdapter())
      ..registerAdapter(TodoAdapter());

    await hive.openBox<Todo>(HiveNamesHelper.todoDatabase);
  }

  Future<Box> getBox({required String typeString}) async {
    try {
      Box box;
      switch (typeString) {
        case HiveNamesHelper.todoDatabase:
          box = boxes.getTaskList();
          break;
        default:
          throw LocalCacheException(errorText: "Error interno");
      }
      return box;
    } catch (e) {
      throw LocalCacheException(errorText: "Erro ao buscar dados");
    }
  }
}
