import 'package:daily_do_with_hive/models/todo_model.dart';
import 'package:hive/hive.dart';


class ToDoAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 0;

  @override
  TodoModel read(BinaryReader reader) {
    return TodoModel(
      id: reader.readString(),
      title: reader.readString(),
      isCompleted: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeBool(obj.isCompleted);
  }
}