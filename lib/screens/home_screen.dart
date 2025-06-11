import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/local_database.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  /*------------------------- Variables ------------------------*/

  final _myBox = Hive.box('myBox'); //Reference the HiveBox
  TodoDatabase todoDatabase = TodoDatabase();

  final todoList = ToDo.todoList();
  List<ToDo> _foundTodo = []; // Empty List For Search Item

  final _textController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _focusNode = FocusNode(); // For Remove TextField Focus
  String _searchKeyword = '';


  /*------------------------- initiate ------------------------*/
  @override
  void initState() {

    if(_myBox.get("TODOLIST") == null){
      todoDatabase.todoList = [];
    }
    else {
      //There already exists data
      todoDatabase.loadData();
    }
    _foundTodo = todoDatabase.todoList;

    super.initState();
  }

  /*------------------------- Dispose ------------------------*/
  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async {
        if (_searchController.text.isNotEmpty) {
          setState(() {
            _searchController.clear();
            _runFilter('');
          });
          return false; // Block Back Button
        }
        return true; // Close app with Back Button
      },

      child: Scaffold(
        backgroundColor: tdBgColor,

        appBar: _buildAppBar(),

        body: SafeArea(

          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [

                      searchBox(),

                      /*------------------------------ List View --------------------------*/
                      Expanded(
                        child: _foundTodo.isEmpty? Center(
                            child: Text(
                              'No ToDos Yet!',
                              style: TextStyle(fontSize: 18, color: tdGrey),
                            )
                        )
                        :
                        ListView(
                          children: [

                            Container(
                              margin: EdgeInsets.only(top: 50, bottom: 20),
                              child: Text(
                                'All ToDos',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),

                            for( ToDo todo in _foundTodo.reversed)
                              TodoItem(
                                todo: todo,
                                onToDoChanged: _handleTodoChange,
                                onDeleteItem: _deleteTodoItem,
                              )

                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.0
                              )
                            ],
                            borderRadius: BorderRadius.circular(10)
                          ),

                          /*------------------------------ Text Field --------------------------*/
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: 'Add a new task',
                              border: InputBorder.none
                            ),
                          ),
                        ),
                      ),

                      /*------------------------------ Add Button --------------------------*/
                      Container(
                        margin: EdgeInsets.only(bottom: 20, right: 20),
                        child: FloatingActionButton(
                            onPressed: (){
                              _addNewToDoItem(_textController.text);
                            },
                            backgroundColor: tdBlue,
                            child: Icon(Icons.add, color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),

      ),
    );
  }


/*------------------------------ Handle ToDos --------------------------*/
void _handleTodoChange(ToDo todo){
  setState(() {
    todo.isDone = !todo.isDone;
  });
  todoDatabase.updateDatabase();
}

/*------------------------------ Delete ToDos Item --------------------------*/
void _deleteTodoItem(String id){
  setState(() {
    todoDatabase.todoList.removeWhere((item) => item.id == id);
  });
  todoDatabase.updateDatabase();
  _runFilter(_searchKeyword);
}

/*------------------------------ Create New To Do --------------------------*/
void _addNewToDoItem(String todo){
  setState(() {
    if(_textController.text.isNotEmpty){
      todoDatabase.todoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo));
    }
  });
  _textController.clear();
  _focusNode.unfocus();
}

/*------------------------------ Search To Do Item --------------------------*/
void _runFilter(String enteredKeyword){
  List<ToDo> results = [];

  if(enteredKeyword.isEmpty){
    results = todoDatabase.todoList;
  }
  else{
    results = todoDatabase.todoList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
  }

  setState(() {
    _foundTodo = results; // Search Result
  });
}


/*------------------------------ SearchBox --------------------------*/
  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          _searchKeyword = value;
          _runFilter(value);
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)
        ),
      ),
    );
  }

  /*------------------------------ AppBar --------------------------*/
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBgColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30),

          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.webp'),
            ),
          )
        ],
      ),

    );
  }
}
