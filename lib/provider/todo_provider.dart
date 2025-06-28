import 'package:daily_do_with_hive/models/todo_model.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class TodoProvider extends ChangeNotifier {

  final _myBox = Hive.box('myBox'); //Hive Local Database Reference
  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  TodoProvider() {
    loadTodos();
  }

  // -------------- Load Tasks from Hive Database ---------
  void loadTodos() {
    _todos = _myBox.get('TODOLIST')?.cast<TodoModel>() ?? [];
    notifyListeners();
  }

  // ------------ Add New Task -------
  void addTodo(String title) {
    if (title.trim().isEmpty) return;

    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    );

    _todos.add(todo);
    _save();
  }

  // -------------- Edit Tasks ---------
  void editTodo(TodoModel todo, String newTitle) {
    todo.title = newTitle;
    _save();
  }

  // -------------- Delete Tasks ---------
  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    _save();
  }

  // -------------- Toggle Task Status ---------
  void toggleStatus(TodoModel todo) {
    todo.isCompleted = !todo.isCompleted;
    _save();
  }


  // -------------- Count Active and Completed Tasks ---------
  int get activeCount => _todos.where((t) => !t.isCompleted).length;
  int get completedCount => _todos.where((t) => t.isCompleted).length;

  List<TodoModel> filteredTodos(bool showActive) =>
      _todos.where((t) => t.isCompleted != showActive).toList();

  // -------------- Save Tasks to Hive Database ---------
  void _save() {
    _myBox.put('TODOLIST', _todos);
    notifyListeners();
  }
}