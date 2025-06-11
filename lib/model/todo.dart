
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ToDo {

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? todoText;

  @HiveField(2)
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false
  });

  static List<ToDo> todoList() {
    return [
      // ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      // ToDo(id: '02', todoText: 'Buy Groceries', isDone: false),
    ];
  }
}