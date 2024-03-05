import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_estado_todo/controller/todo_controller.dart';
import '../widgets/add_todo_form_widget.dart';

final todoCtrl = TodoController();

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Todos com Signals',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (_) => const AddTodoFormWidget()),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.black,
      body: Watch((context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    todoCtrl.todosStatusString.value,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: todoCtrl.todos.length,
                  itemBuilder: (_, int index) {
                    final todo = todoCtrl.todos[index];
                    return ListTile(
                      leading: Checkbox(
                        value: todo.completed,
                        onChanged: (_) => todoCtrl.onChangedCompletedTodo(todo),
                      ),
                      title: Text(
                        todo.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      subtitle: Text(
                        todo.description ?? '',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      trailing: IconButton(
                        onPressed: () => todoCtrl.onRemoveTodo(todo),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
