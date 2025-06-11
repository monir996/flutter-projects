import 'package:hive/hive.dart';
import 'package:mini_todo/model/todo.dart';

class TodoDatabase {

  //---------------- List of todo_tasks
  List<ToDo> todoList = [];



  //---------------- Hive - Local Database
  final _myBox = Hive.box('myBox');


  //---------------- Update Database
  void updateDatabase(){
    _myBox.put("TODOLIST", todoList);
  }


  //---------------- Load data from database
  void loadData(){
    todoList = _myBox.get("TODOLIST")?.cast<ToDo>() ?? [];
  }


}