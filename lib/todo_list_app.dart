import 'package:exame_todo_list/core/resources/constants.dart';
import 'package:exame_todo_list/core/router/router.dart' as TodoList;
import 'package:exame_todo_list/core/router/routes.dart';
import 'package:exame_todo_list/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TodoListApp extends StatefulWidget {
  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      theme: appTheme,
      navigatorKey: Constants.appGlobalKey,
      debugShowCheckedModeBanner: false,
      title: 'TodoList',
      onGenerateRoute: TodoList.Router.generateRoute,
      initialRoute: Routes.home,
    );
  }
}
