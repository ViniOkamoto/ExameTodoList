import 'package:exame_todo_list/core/theme/colors.dart';
import 'package:exame_todo_list/core/theme/typography.dart';
import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:exame_todo_list/features/enums/todo_category_enum.dart';
import 'package:exame_todo_list/features/enums/todo_priority_enum.dart';
import 'package:exame_todo_list/features/widgets/dropdown_text_field.dart';
import 'package:exame_todo_list/features/widgets/spacing.dart';
import 'package:exame_todo_list/features/widgets/todo_button.dart';
import 'package:exame_todo_list/features/widgets/todo_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Row(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TodoForm(),
                  TodoPrimaryButton(
                    text: "Criar tarefa",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TodoForm extends StatefulWidget {
  const _TodoForm({Key? key}) : super(key: key);

  @override
  __TodoFormState createState() => __TodoFormState();
}

class __TodoFormState extends State<_TodoForm> {
  var categoryValue;
  var priorityValue;
  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TodoTextField(
          hintText: "Digite o nome da tarefa",
          textEditingController: TextEditingController(),
          onChanged: (onChanged) {},
        ),
        Spacing(height: 16),
        Row(
          children: [
            Flexible(
              flex: 6,
              child: TextField(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  _selectDate(context);
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
                onChanged: (newValue) {
                  // do other stuff with _category
                  setState(() => priorityValue = newValue);
                },
                value: priorityValue,
              ),
            ),
          ],
        ),
        Spacing(height: 16),
        SizedBox(
          width: SizeConverter.relativeWidth(182),
          child: _CategoryDropDown(
            onChanged: (newValue) {
              // do other stuff with _category
              setState(() => categoryValue = newValue);
            },
            value: categoryValue,
          ),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (picked != null && picked != selectedDate)
      setState(
        () {
          selectedDate = picked;
          var date = "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
          dateController.text = date;
        },
      );
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
        (TodoCategoryEnum category) {
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
