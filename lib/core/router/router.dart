import 'package:exame_todo_list/core/router/routes.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/screens/home/home_page.dart';
import 'package:exame_todo_list/features/screens/todo/todo_page.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomePage(), settings: settings);
      case Routes.todo:
        final todo = settings.arguments as Todo?;
        return MaterialPageRoute(builder: (_) => TodoPage(todo: todo), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
