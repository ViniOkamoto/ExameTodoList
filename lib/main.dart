import 'package:exame_todo_list/core/services/hive/hive_service.dart';
import 'package:exame_todo_list/todo_list_app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting('pt_BR', null).then((value) => runApp(TodoListApp()));
}
