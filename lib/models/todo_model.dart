import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {

  @HiveField(0)
  String id;
  
  @HiveField(1)
  String title;

  @HiveField(2)
  bool isCompleted;

  TodoModel({required this.id, required this.title, this.isCompleted = false});

  // static List<TodoModel> todoList = [
  //   TodoModel(id: '01', title: 'Morning Exercise', isCompleted: true),
  //   TodoModel(id: '02', title: 'Buy Groceries', isCompleted: false),
  // ];
}