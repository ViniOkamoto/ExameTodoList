import 'package:exame_todo_list/core/services/di/service_locator.dart';
import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/theme/typography.dart';
import 'package:exame_todo_list/core/utils/form_status.dart';
import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/events/todo_event.dart';
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
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late final TodoBloc _todoBloc;
  @override
  void initState() {
    _todoBloc = serviceLocator<TodoBloc>();
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
                        bottom: SizeConverter.relativeHeight(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _TodoForm(),
                        Spacing(
                          height: 160,
                        ),
                        BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
                          return TodoPrimaryButton(
                            text: "Criar tarefa",
                            child: state.formStatus is FormSubmitting ? CircularProgressIndicator() : null,
                            onPressed: state.isValidForm
                                ? () {
                                    context.read<TodoBloc>().add(TodoSubmitted());
                                  }
                                : null,
                          );
                        }),
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
  @override
  __TodoFormState createState() => __TodoFormState();
}

class __TodoFormState extends State<_TodoForm> {
  final TextEditingController dateController = TextEditingController();
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
              hintText: "Digite o nome da tarefa",
              onChanged: (String title) => context.read<TodoBloc>().add(
                    TodoTitleChanged(title: title),
                  ),
            ),
            Spacing(height: 16),
            Row(
              children: [
                Flexible(
                  flex: 6,
                  child: TextField(
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      DateTime? datePicked = await _openDatePicker(context);
                      if (datePicked != null && datePicked != state.dateTime) {
                        context.read<TodoBloc>().add(TodoDateChanged(date: datePicked));
                        var date =
                            "${datePicked.toLocal().day}/${datePicked.toLocal().month}/${datePicked.toLocal().year}";
                        dateController.text = date;
                      }
                    },
                    style: TodoTypo.p2(
                      color: TodoColors.darkerColor,
                    ),
                    controller: dateController,
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
                  flex: 4,
                  child: _PriorityDropDown(
                    onChanged: (priority) => context.read<TodoBloc>().add(
                          TodoPriorityChanged(priority: priority),
                        ),
                    value: state.priority,
                  ),
                ),
              ],
            ),
            Spacing(height: 16),
            SizedBox(
              width: SizeConverter.relativeWidth(182),
              child: _CategoryDropDown(
                onChanged: (category) => context.read<TodoBloc>().add(
                      TodoCategoryChanged(category: category),
                    ),
                value: state.category,
              ),
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
  _PriorityDropDown({required this.onChanged, required this.value});
  final Function(dynamic) onChanged;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      hintText: "Prioridade",
      items: priorityList.map((TodoPriorityEnum priority) {
        return new DropdownMenuItem(
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
  _CategoryDropDown({required this.onChanged, required this.value});
  final Function(dynamic) onChanged;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      hintText: "Categoria",
      items: categoryList.map(
        (TodoCategoryEnum? category) {
          return DropdownMenuItem(
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
