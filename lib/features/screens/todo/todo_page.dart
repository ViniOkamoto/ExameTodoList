import 'package:exame_todo_list/core/services/di/service_locator.dart';
import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/theme/typography.dart';
import 'package:exame_todo_list/core/utils/date_helper.dart';
import 'package:exame_todo_list/core/utils/form_status.dart';
import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/events/todo_event.dart';
import 'package:exame_todo_list/features/models/todo.dart';
import 'package:exame_todo_list/features/screens/todo/todo_bloc.dart';
import 'package:exame_todo_list/features/state/todo_state.dart';
import 'package:exame_todo_list/features/widgets/dropdown_text_field.dart';
import 'package:exame_todo_list/features/widgets/spacing.dart';
import 'package:exame_todo_list/features/widgets/todo_button.dart';
import 'package:exame_todo_list/features/widgets/todo_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  final Todo? todo;
  TodoPage({this.todo});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late final TodoBloc _todoBloc;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  @override
  void initState() {
    _todoBloc = serviceLocator<TodoBloc>();
    if (widget.todo != null)
      _todoBloc.add(
        TodoEditing(
          todo: widget.todo!,
          dateController: dateController,
          titleController: titleController,
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => _todoBloc,
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state.exception != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.exception!.errorText!),
                  backgroundColor: TodoColors.redPriorityColor,
                ),
              );
            }
            if (state.formStatus is SubmissionSuccess) {
              Navigator.pop(context);
            }
          },
          child: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConverter.relativeWidth(16),
                      right: SizeConverter.relativeWidth(16),
                      top: SizeConverter.relativeWidth(120),
                      bottom: SizeConverter.relativeHeight(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _TodoForm(dateController: dateController, titleController: titleController),
                        Spacing(height: 160),
                        BlocBuilder<TodoBloc, TodoState>(
                          builder: (context, state) {
                            return TodoPrimaryButton(
                              key: Key("button"),
                              text: state.isEditing ? "Editar Tarefa" : "Criar Tarefa",
                              child: state.formStatus is FormSubmitting ? CircularProgressIndicator() : null,
                              onPressed: state.isValidForm
                                  ? () {
                                      context.read<TodoBloc>().add(TodoSubmitted(todo: widget.todo));
                                    }
                                  : null,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TodoForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController dateController;
  _TodoForm({required this.dateController, required this.titleController});

  @override
  __TodoFormState createState() => __TodoFormState();
}

class __TodoFormState extends State<_TodoForm> {
  var categoryValue;
  var priorityValue;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodoTextField(
              key: Key("title_text_field"),
              textEditingController: widget.titleController,
              hintText: "Digite o nome da tarefa",
              onChanged: (String title) => context.read<TodoBloc>().add(
                    TodoTitleChanged(title: title),
                  ),
            ),
            Spacing(height: 16),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    key: Key("date_text_field"),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      DateTime? datePicked = await _openDatePicker(context);
                      if (datePicked != null && datePicked != state.dateTime) {
                        context.read<TodoBloc>().add(TodoDateChanged(date: datePicked));
                        widget.dateController.text = DateHelper.textFieldString(datePicked);
                      }
                    },
                    style: TodoTypo.p2(
                      color: TodoColors.darkerColor,
                    ),
                    controller: widget.dateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        size: SizeConverter.fontSize(24),
                        color: TodoColors.grayColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: TodoColors.lighterColor, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: TodoColors.lighterColor, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      hintText: "Data final",
                      errorText: null,
                    ),
                  ),
                ),
                Spacing(
                  width: 16,
                ),
                Flexible(
                  child: _PriorityDropDown(
                    key: Key("priority_drop_down"),
                    onChanged: (priority) => context.read<TodoBloc>().add(
                          TodoPriorityChanged(priority: priority),
                        ),
                    value: state.priority,
                  ),
                ),
              ],
            ),
            Spacing(height: 16),
            _CategoryDropDown(
              key: Key("category_drop_down"),
              onChanged: (category) => context.read<TodoBloc>().add(
                    TodoCategoryChanged(category: category),
                  ),
              value: state.category,
            ),
          ],
        );
      },
    );
  }

  _openDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    return picked;
  }
}

class _PriorityDropDown extends StatelessWidget {
  _PriorityDropDown({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final Function(dynamic) onChanged;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      hintText: "Prioridade",
      items: priorityList.map((TodoPriorityEnum priority) {
        return DropdownMenuItem(
          key: UniqueKey(),
          value: priority,
          child: Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(shape: BoxShape.circle, color: priorityColor[priority]),
              ),
              Spacing(width: 8),
              Text(
                priorityName[priority]!,
                style: TodoTypo.p2(color: TodoColors.darkerColor),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
      value: value,
    );
  }
}

class _CategoryDropDown extends StatelessWidget {
  _CategoryDropDown({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final Function(dynamic) onChanged;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      hintText: "Categoria",
      items: categoryList.map(
        (TodoCategoryEnum category) {
          return DropdownMenuItem(
            key: Key("category_item_${category.index}"),
            value: category,
            child: Row(
              children: <Widget>[
                Icon(
                  categoryIcons[category],
                  size: SizeConverter.relativeWidth(24),
                  color: categoryColor[category],
                ),
                Spacing(width: 8),
                Text(
                  categoryName[category]!,
                  style: TodoTypo.p2(
                    color: TodoColors.darkerColor,
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
      onChanged: onChanged,
      value: value,
    );
  }
}
