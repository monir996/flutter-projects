import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../model/todo.dart';

class TodoProvider extends ChangeNotifier {

  final _myBox = Hive.box('myBox'); //Hive Local Database Reference
  List<ToDo> _todos = [];

  List<ToDo> get todos => _todos;
  String _searchKeyword = '';

  TodoProvider() {
    loadTodos();
  }

  void loadTodos() {
    _todos = _myBox.get("TODOLIST")?.cast<ToDo>() ?? [];
    notifyListeners();
  }

  void addTodo(String text) {

    if (text.trim().isEmpty) return;

    final todo = ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: text.trim(),
    );
    _todos.add(todo);
    _save();
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _save();
  }

  void toggleDone(ToDo todo) {
    todo.isDone = !todo.isDone;
    _save();
  }

  void _save() {
    _myBox.put("TODOLIST", _todos);
    notifyListeners();
  }

  void search(String keyword) {
    _searchKeyword = keyword.toLowerCase();
    notifyListeners();
  }

  List<ToDo> get filteredTodos {
    if (_searchKeyword.isEmpty) return _todos;
    return _todos
        .where((todo) => todo.todoText!.toLowerCase().contains(_searchKeyword))
        .toList();
  }

}