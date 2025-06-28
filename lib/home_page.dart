import 'package:flutter/material.dart';
import '../components/dialog_box.dart';
import '../components/todo_card.dart';
import '../components/todo_tile.dart';
import '../models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<TodoModel> todoList = [];
  bool showActiveTask = true;

  //----------------- Add New Task -----------------
  void _addNewTask(String title){
    setState(() => todoList.add(TodoModel(title)));
  }

  //----------------- Edit Task -----------------
  void _editTask(String updatedText, int index){
    setState(() => todoList[index].title = updatedText);
  }

  //----------------- Delete Task -----------------
  void _deleteTask(int index){
    setState(() => todoList.removeAt(index));
  }

  //----------------- Show Dialog -----------------
  void _showDialogBox({int? index}){

    final controller = TextEditingController(
      text: index != null ? todoList[index].title : ''
    );

    showDialog(
        context: context,
        builder: (context)=> DialogBox(
            controller: controller,
            index: index,
            onSave: (){
              if(index == null){
                _addNewTask(controller.text);
                controller.clear();
              } else {
                _editTask(controller.text, index);
              }
            }
        )
    );

  }


  // -------------- Count Active and Completed Task --------------
  int get activeTaskCount => todoList.where((task) => !task.isCompleted).length;
  int get completedTaskCount => todoList.where((task) => task.isCompleted).length;



  // --------------------------------- Build Widget Start ------------------------------
  @override
  Widget build(BuildContext context) {


    // ---------------------- Filter Tasks ---------------
    List<TodoModel> filteredTodos = todoList.where((task) => task.isCompleted != showActiveTask).toList();

    // ------------- Toggle the task completion status ----------
    void toggleStatus(int index) {
      setState(()=> filteredTodos[index].isCompleted = !filteredTodos[index].isCompleted);
    }



    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        actionsPadding: EdgeInsets.symmetric(horizontal: 16),

        leading: Icon(Icons.menu),
        title: Text('Daily Do', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          Icon(Icons.settings_outlined)
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogBox,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),


      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(24),


          child: Column(
            children: [

              // -------------- Card Item -----------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TodoCard(
                      count: activeTaskCount.toString(),
                      text: 'Active',
                      color: Colors.deepOrange,
                      onTap: (){
                        setState(()=> showActiveTask = true);
                      }
                  ),

                  SizedBox(width: 20),

                  TodoCard(
                      count: completedTaskCount.toString(),
                      text: 'Completed',
                      color: Colors.blueAccent,
                      onTap: (){
                        setState(()=> showActiveTask = false);
                      }
                  ),
                ],
              ),

              SizedBox(height: 30),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        showActiveTask ? 'Active ToDos' : 'Completed ToDos',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: showActiveTask ? Colors.deepOrange : Colors.blueAccent
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    Expanded(
                      child: filteredTodos.isEmpty
                      ? Center(child: Text('No ToDos yet.'))
                      : ListView.builder(
                        itemCount: filteredTodos.length,
                        itemBuilder: (context, index){

                          final task = filteredTodos[index];
                          final originalIndex = todoList.indexOf(task);

                          // -------------- List Tile -----------
                          return TodoTile(
                              todo: task,
                              onChanged: ()=> toggleStatus(index),
                              onEdit: ()=> _showDialogBox(index: originalIndex),
                              onDelete: ()=> _deleteTask(originalIndex),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


