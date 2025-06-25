import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {

  final controller;
  final index;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.index,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {

  String? _errorText;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(widget.index == null ? 'Add Task' : 'Edit Task'),
      content: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Write your task here',
          errorText: _errorText,
        ),
      ),
      actions: [
        TextButton(
            onPressed: widget.onCancel,
            child: Text('Cancel')
        ),
        ElevatedButton(
          onPressed: (){
            final text = widget.controller.text.trim();
            if (text.isEmpty) {
              setState(() => _errorText = 'Task cannot be empty');
            } else {
              setState(() => _errorText = null); // Clear error
              widget.onSave();
            }
          },
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white
          ),
          child: Text('Save'),
        )
      ],
    );
  }
}

