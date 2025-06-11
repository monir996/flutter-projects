import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/todo.dart';

class TodoItem extends StatelessWidget {

  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const TodoItem({super.key, required this.todo, required this.onToDoChanged, required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.only(bottom: 20),

        /*------------------------------ List Tile Item --------------------------*/
        child: ListTile(
          onTap: (){
            onToDoChanged(todo);
          },

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),

          tileColor: Colors.white,

          /*------------------------------ To Do CheckBox --------------------------*/
          leading: Icon(
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              color: tdBlue
          ),

          /*------------------------------ To Do Text --------------------------*/
          title: Text(
            todo.todoText!,
            style: TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none
            ),
          ),

          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

          /*------------------------------ Delete Icon --------------------------*/
          trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(color: tdRed, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
                onPressed: (){
                  onDeleteItem(todo.id);
                },
                icon: Icon(Icons.delete_forever),
                color: Colors.white,
                iconSize: 18,
            ),
          ),
        )
    );
  }
}
