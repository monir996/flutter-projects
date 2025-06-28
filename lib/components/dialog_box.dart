import 'package:daily_do_with_hive/models/todo_model.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {

  final TextEditingController controller;
  final TodoModel? todo;
  final VoidCallback onSave;

  const DialogBox({
    super.key,
    required this.controller,
    required this.todo,
    required this.onSave,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  String? errorText;

  void _handleSave() {
    final text = widget.controller.text.trim();
    if (text.isEmpty) {
      setState(() => errorText = 'Task cannot be empty.');
    } else {
      setState(() => errorText = null);
      Navigator.pop(context);
      widget.onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.todo == null ? 'Add Todo' : 'Edit Task'),
      content: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Write your todo here...',
          errorText: errorText,
          //border: OutlineInputBorder(),
        ),
        autofocus: true,
        onSubmitted: (_) => _handleSave(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: Colors.blueAccent),),
        ),
        ElevatedButton(
          onPressed: _handleSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: StadiumBorder(),
          ),
          child: Text('Save'),
        ),
      ],
    );
  }
}
