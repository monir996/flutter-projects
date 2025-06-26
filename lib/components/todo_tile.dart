import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoTile({
    super.key, required this.todo, required this.onChanged, required this.onEdit, required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.all(10),

        leading: Checkbox(
            activeColor: Colors.blueAccent,
            shape: CircleBorder(),
            value: todo.isCompleted,
            onChanged: (_)=> onChanged()
        ),

        title: Text(todo.title, style: TextStyle(
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null
        )),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.edit)
            ),

            IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete)
            ),
          ],
        ),
      ),
    );
  }
}