import 'package:daily_do/components/dialog_box.dart';
import 'package:flutter/material.dart';
import '../components/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //List<Map<String, dynamic>> tasks = [];

  List toDoList = [
    ['Make Tutorial', false],
    ['Exercise', false]
  ];

  bool showActiveTask = true;



  // ------------ Add New Task -------
  void _addNewTask(String text)
  {
    setState(() {
      // tasks.add({
      //   'task' : task,
      //   'completed' : false
      // });
      if(text.trim().isNotEmpty){
        toDoList.add([text, false]);
      }
    });
  }

  // ------------ Add New Task -------
  void _editTask(String updatedTask, int index)
  {
    setState(() {
      toDoList[index][0] = updatedTask;
    });
  }

  // -------------- Count Active Tasks ---------
  int get activeTasksCount => toDoList.where((task) => !task[1]).length;
  int get completedTasksCount => toDoList.where((task) => task[1]).length;

  // ----------- Show Dialog -------
  void _showAddTaskDialog({int? index}) {

    final _controller = TextEditingController(
      text: index != null ? toDoList[index][0] : ''
    );

    showDialog(
      context: context,
      builder: (context) => DialogBox(
          controller: _controller,
          index: index,
          onSave: (){
            if(index == null){
              _addNewTask(_controller.text);
              _controller.clear();
              Navigator.pop(context);
            } else {
              _editTask(_controller.text, index);
              Navigator.pop(context);
            }
          },
          onCancel: () => Navigator.pop(context),
      ),
    );
  }

  // -------------- Delete Tasks ---------
  void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
    });
  }



  // --------------------------- Build Widget Start ----------
  @override
  Widget build(BuildContext context) {

    // -------------- Filter Tasks ---------
    List filteredTodos = toDoList.where((task) => task[1] != showActiveTask).toList();

    // -------------- Change Task Status ---------
    void toggleTaskStatus(int index){
      setState(() {
        filteredTodos[index][1] = !filteredTodos[index][1];
      });
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text('DailyDo', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  CardWidget(
                      count: activeTasksCount.toString(),
                      text: 'Active',
                      color: Colors.deepOrange,
                      onTap: (){
                        setState(() {
                          showActiveTask = true;
                        });
                      },
                  ),

                  SizedBox(width: 20),

                  CardWidget(
                      count: completedTasksCount.toString(),
                      text: 'Completed',
                      color: Colors.green,
                      onTap: (){
                        setState(() {
                          showActiveTask = false;
                        });
                      },
                  ),

                ],
              ),

              SizedBox(height: 30),

              // ------------------------ List View ------------------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),

                  child: ListView.builder(
                      itemCount: filteredTodos.length,
                      itemBuilder: (context, index) {

                        return Dismissible(
                          key: Key(UniqueKey().toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                                //bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Icon(Icons.delete, color: Colors.white,),
                          ),
                          onDismissed: (direction){
                            if(direction == DismissDirection.endToStart){
                              deleteTask(index);
                            }
                          },

                          // -------------- List Tile ---------
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(

                                leading: Checkbox(
                                    shape: CircleBorder(),
                                    value: filteredTodos[index][1],
                                    onChanged: (_) => toggleTaskStatus(index)
                                ),
                                title: Text(
                                    filteredTodos[index][0],
                                    style: TextStyle(
                                        fontSize: 16,
                                        decoration: filteredTodos[index][1] ? TextDecoration.lineThrough : null
                                    ),
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: ()=> _showAddTaskDialog(index: index),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}


