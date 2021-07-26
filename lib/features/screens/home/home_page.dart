import 'package:dartx/dartx.dart';
import 'package:exame_todo_list/core/router/routes.dart';
import 'package:exame_todo_list/core/services/di/service_locator.dart';
import 'package:exame_todo_list/core/services/hive/boxes.dart';
import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/theme/typography.dart';
import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/events/home_event.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/screens/home/home_bloc.dart';
import 'package:exame_todo_list/features/screens/home/widgets/category_card.dart';
import 'package:exame_todo_list/features/screens/home/widgets/todo_card.dart';
import 'package:exame_todo_list/features/state/home_state.dart';
import 'package:exame_todo_list/features/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = serviceLocator<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: SizeConverter.fontSize(24),
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.todo);
        },
      ),
      backgroundColor: TodoColors.lightestColor,
      body: BlocProvider(
        create: (context) => _homeBloc,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeaderPage(),
                    _CategoryList(),
                    Spacing(height: 24),
                    _TodoList(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    _homeBloc.close();
    super.dispose();
  }
}

class _HeaderPage extends StatelessWidget {
  const _HeaderPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConverter.relativeWidth(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacing(height: 24),
          Text(
            "O que vamos fazer?",
            style: TodoTypo.h1(color: TodoColors.darkestColor),
          ),
          Spacing(height: 24),
        ],
      ),
    );
  }
}

class _TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConverter.relativeWidth(16),
            ),
            child: Text(
              "TAREFAS",
              style: TodoTypo.h3(color: TodoColors.grayColor),
            ),
          ),
          Spacing(height: 16),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return ValueListenableBuilder<Box<Todo>>(
                valueListenable: Boxes().getTaskList().listenable(),
                builder: (contextListenable, box, _) {
                  context.read<HomeBloc>().add(FetchTaskList(todoList: box.values.toList().cast<Todo>()));
                  List<Todo> todoList = state.todoList;
                  if (state.categoryFilter != null) todoList = _buildFilteredList(todoList, state.categoryFilter!);
                  if (todoList.isEmpty)
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConverter.relativeWidth(40),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.done_all,
                              size: SizeConverter.fontSize(80),
                              color: TodoColors.highlightColor,
                            ),
                            Text(
                              "Parece que você não possui nenhuma tarefa!",
                              textAlign: TextAlign.center,
                              style: TodoTypo.p2(color: TodoColors.darkestColor),
                            )
                          ],
                        ),
                      ),
                    );
                  return Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConverter.relativeWidth(16), vertical: SizeConverter.relativeHeight(16)),
                      itemBuilder: (context, index) {
                        Todo todo = todoList[index];
                        return TodoCard(
                          onDelete: () {
                            context.read<HomeBloc>().add(TodoDeleted(todo: todo, index: index));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tarefa excluída'),
                              ),
                            );
                          },
                          onEdit: () {
                            Navigator.pushNamed(context, Routes.todo, arguments: todo);
                          },
                          todo: todo,
                          onChanged: (bool) {
                            todo.itsDone = bool!;
                            context.read<HomeBloc>().add(
                                  TodoTouched(
                                    todo: todo,
                                  ),
                                );
                          },
                        );
                      },
                      itemCount: todoList.length,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  _buildFilteredList(List<Todo> list, TodoCategoryEnum category) {
    return list.filter((element) => element.category.index == categoryIndex[category]).toList();
  }
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: SizeConverter.relativeWidth(16),
              ),
              child: Text(
                "CATEGORIAS",
                style: TodoTypo.h3(color: TodoColors.grayColor),
              ),
            ),
            Container(
              height: 130,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConverter.relativeWidth(16),
                  vertical: SizeConverter.relativeHeight(16),
                ),
                itemCount: categoryList.length,
                separatorBuilder: (context, index) {
                  return Spacing(width: 24);
                },
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  int quantity = 0;
                  switch (index) {
                    case 0:
                      quantity = state.workQuantity ?? 0;
                      break;
                    case 1:
                      quantity = state.personalQuantity ?? 0;
                      break;
                    case 2:
                      quantity = state.wellnessQuantity ?? 0;
                      break;
                    case 3:
                      quantity = state.otherQuantity ?? 0;
                      break;
                  }
                  return CategoryCard(
                    onTap: () {
                      context.read<HomeBloc>().add(FilterList(category: categoryList[index]));
                    },
                    isSelected: state.categoryFilter == categoryList[index],
                    category: categoryList[index],
                    taskQuantity: quantity,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
