import 'package:signals/signals.dart';
import 'package:signals_estado_todo/models/todo_model.dart';

class TodoController{
  final todos = <TodoModel>[].toSignal();

  late final Computed<String> todosStatusString = computed((){
    final notCompletedTodos = todos.where((todo) => !todo.completed);
    if(todos.isEmpty){
      return "Você não possui nenhuma tarefa";
    }else if(notCompletedTodos.isEmpty){
      return "Parabéns! Todas as tarefas estão completas";
    }
    return "Você possui ${notCompletedTodos.length} tarefas ${notCompletedTodos.length == 1 ? '' : 's'}";
  });

  void onAddTodo(TodoModel todo){
    todos.add(todo);
  }

  void onRemoveTodo(TodoModel todo){
    todos.removeWhere((todoFromList) => todoFromList.id == todo.id);
  }

  void onChangedCompletedTodo(TodoModel todoToUpdate){
    todos.value = todos.map((todo){
      if(todo.id == todoToUpdate.id){
        return todo.copyWith(completed: !todoToUpdate.completed);
      }
      return todo;
    }).toList();
  }
}