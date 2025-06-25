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
    ['Morning Walk', false],
    ['Do Exercise', false]
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
            } else {
              _editTask(_controller.text, index);
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

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        
        leading: Icon(Icons.menu),
        
        title: Text('DailyDo', style: TextStyle(fontWeight: FontWeight.bold),),
        
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.settings_outlined),
          )
        ],
        
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
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          showActiveTask ? 'Active ToDos' : 'Completed ToDos',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: showActiveTask ? Colors.deepOrange : Colors.green
                          ),
                        ),
                      ),


                      SizedBox(height: 10),

                      Expanded(
                        child: toDoList.isEmpty
                            ? Center(child: Text('No ToDos yet.'))
                            : ListView.builder(
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
                                    final i = toDoList.indexOf(filteredTodos[index]);
                                    deleteTask(i);
                                  }
                                },

                                // -------------- List Tile -----------
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),

                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(8),

                                      leading: Checkbox(
                                          activeColor: Colors.blueAccent,
                                          shape: CircleBorder(),
                                          value: filteredTodos[index][1],
                                          onChanged: (_){
                                            setState(() {
                                              final i = toDoList.indexOf(filteredTodos[index]);
                                              toDoList[i][1] = !toDoList[i][1];
                                            });
                                          }
                                      ),

                                      title: Text(
                                        filteredTodos[index][0],
                                        style: TextStyle(
                                            fontSize: 16,
                                            decoration: filteredTodos[index][1] ? TextDecoration.lineThrough : null
                                        ),
                                      ),

                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: ()=> _showAddTaskDialog(index: toDoList.indexOf(filteredTodos[index])),
                                              icon: Icon(Icons.edit)
                                          ),
                                          IconButton(
                                              onPressed: (){
                                                final i = toDoList.indexOf(filteredTodos[index]);
                                                deleteTask(i);
                                              },
                                              icon: Icon(Icons.delete)
                                          ),
                                        ],

                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ],
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


