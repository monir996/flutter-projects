import 'package:hive/hive.dart';
import '../model/todo.dart';

class ToDoAdapter extends TypeAdapter<ToDo> {
  @override
  final int typeId = 0;

  @override
  ToDo read(BinaryReader reader) {
    return ToDo(
      id: reader.readString(),
      todoText: reader.readString(),
      isDone: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, ToDo obj) {
    writer.writeString(obj.id!);
    writer.writeString(obj.todoText!);
    writer.writeBool(obj.isDone);
  }
}
