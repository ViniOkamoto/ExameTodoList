import 'package:exame_todo_list/core/services/hive/hive_helper.dart';
import 'package:exame_todo_list/todo_list_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await HiveService.init();

  runApp(TodoListApp());
}
