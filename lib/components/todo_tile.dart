import 'package:flutter/material.dart';
import '/models/todo_model.dart';
import '/constants/colors.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: tileBgColor,
        borderRadius: BorderRadius.circular(12),
      ),

      child: ListTile(
        contentPadding: EdgeInsets.all(10),

        leading: Checkbox(
          activeColor: Colors.blueAccent,
          shape: CircleBorder(),
          value: todo.isCompleted,
          onChanged: (_) => onChanged(),
        ),

        title: Text(
          todo.title,
          style: TextStyle(
            decoration:
            todo.isCompleted ? TextDecoration.lineThrough : null,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: tileTxtColor
          ),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit, color: Colors.grey[700]),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
