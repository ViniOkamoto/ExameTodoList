import 'package:exame_todo_list/core/services/hive/boxes.dart';
import 'package:exame_todo_list/core/services/hive/hive_service.dart';
import 'package:exame_todo_list/features/datasources/todo_local_data_source.dart';
import 'package:exame_todo_list/features/repositories/todo_repository.dart';
import 'package:exame_todo_list/features/screens/home/home_bloc.dart';
import 'package:exame_todo_list/features/screens/todo/todo_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final GetIt serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  serviceLocator.registerSingleton<HiveService>((HiveService(hive: Hive, boxes: Boxes())));
  serviceLocator.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImplementation(
      hive: serviceLocator<HiveService>(),
    ),
  );
  serviceLocator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      localSource: serviceLocator<TodoLocalDataSource>(),
    ),
  );

  serviceLocator.registerFactory<TodoBloc>(() => TodoBloc(todoRepository: serviceLocator<TodoRepository>()));
  serviceLocator.registerFactory<HomeBloc>(() => HomeBloc(todoRepository: serviceLocator<TodoRepository>()));
}
