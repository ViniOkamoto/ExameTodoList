import 'package:exame_todo_list/core/utils/size_converter.dart';
import 'package:exame_todo_list/features/widgets/todo_text_field.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                top: SizeConverter.relativeWidth(24),
              ),
              child: Column(
                children: [
                  TodoTextField(
                      hintText: "Digite o nome da tarefa",
                      textEditingController: TextEditingController(),
                      onChanged: (onChanged) {})
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
