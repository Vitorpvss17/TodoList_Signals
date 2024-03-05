import 'package:flutter/material.dart';
import 'package:signals_estado_todo/models/todo_model.dart';
import 'package:signals_estado_todo/screens/todo_screen.dart';

class AddTodoFormWidget extends StatefulWidget {
  const AddTodoFormWidget({super.key});

  @override
  State<AddTodoFormWidget> createState() => _AddTodoFormWidgetState();
}

class _AddTodoFormWidgetState extends State<AddTodoFormWidget> {
  final titleTec = TextEditingController();
  final descriptionTec = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void onAddTodo() {
    if (formKey.currentState!.validate()) {
      final todoToAdd =
          TodoModel(titleTec.text, descriptionC: descriptionTec.text);
      todoCtrl.onAddTodo(todoToAdd);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: titleTec,
              validator: (String? newTitle) {
                if (newTitle == null || newTitle.isEmpty) {
                  return 'Por favor, insira um título';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Título',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: descriptionTec,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descrição',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => onAddTodo(),
              child: const Text('Adicionar tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}
