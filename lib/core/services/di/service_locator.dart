import 'package:exame_todo_list/core/services/hive/hive_service.dart';
import 'package:exame_todo_list/features/datasources/todo_local_data_source.dart';
import 'package:exame_todo_list/features/repositories/todo_repository.dart';
import 'package:exame_todo_list/features/screens/todo/todo_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final GetIt serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  serviceLocator.registerSingleton<HiveService>((HiveService(hive: Hive)));
  serviceLocator.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImplementation(
      hive: serviceLocator<HiveService>(),
    ),
  );
  serviceLocator.registerLazySingleton<TodoRepository>(
    () => TodoRepository(
      localSource: serviceLocator<TodoLocalDataSource>(),
    ),
  );

  serviceLocator.registerFactory(() => TodoBloc(todoRepository: serviceLocator<TodoRepository>()));
}
