import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;

  const DialogBox({super.key, required this.controller, required this.onSave});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Todo'),
      content: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Write your todo here...',
          errorText: errorText
        ),
      ),
      actions: [
        TextButton(
            onPressed: ()=> Navigator.pop(context),
            child: Text('Cancel')
        ),
        ElevatedButton(
            onPressed: (){
              final text = widget.controller.text.trim();
              if(text.isEmpty){
                setState(() => errorText = 'Task cannot be empty.');

              } else {
                setState(() => errorText = null);
                Navigator.pop(context);
                widget.onSave();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              shape: StadiumBorder()
            ),
            child: Text('Save'),
        )
      ],
    );
  }
}
