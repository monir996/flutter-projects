import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../provider/theme_provider.dart';
import '../provider/todo_provider.dart';
import '../widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  /*------------------------- Variables ------------------------*/

  final _textController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _focusNode = FocusNode(); // For Remove TextField Focus


  /*------------------------- Dispose ------------------------*/
  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<ToDo> displayList = Provider.of<TodoProvider>(context).filteredTodos;
    bool isSearching = Provider.of<TodoProvider>(context).isSearching;

    final isDark = Theme.of(context).brightness == Brightness.dark;


    return WillPopScope(

      onWillPop: () async {
        if (_searchController.text.isNotEmpty) {
          _searchController.clear();
          return false; // Block Back Button
        }
        return true; // Close app with Back Button
      },

      child: Scaffold(
        //backgroundColor: tdBgColor,

        appBar: _buildAppBar(),

        onDrawerChanged: (isOpened) {
          if (!isOpened) {
            if (_focusNode.hasFocus) {
              _focusNode.unfocus();
            }
          }
        },

        drawer: Drawer(
          backgroundColor: isDark? Colors.black : tdBgColor,
          child: ListView(
            children: [
              DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Image.asset("assets/images/todo-logo.png")
              ),

              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings');
                },
                title: Text("Settings"),
                trailing: Icon(Icons.settings_outlined),
              ),

              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/about');
                },
                title: Text("About"),
                trailing: Icon(Icons.info_outline),
              ),


            ],
          ),
        ),

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
                        child: displayList.isEmpty? Center(
                            child: Text(
                              isSearching ? 'No search results found.' : 'No ToDos Yet.',
                              style: TextStyle(fontSize: 18, color: tdGrey),
                            )
                        )
                        :
                        ListView(
                          padding: EdgeInsets.only(bottom: 100),
                          children: [

                            Container(
                              margin: EdgeInsets.only(top: 50, bottom: 20),
                              child: Text(
                                'All ToDos',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),

                            for( ToDo todo in displayList.reversed)
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
                            color: tdBgColor,
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
                            focusNode: _focusNode,
                            controller: _textController,
                            style: TextStyle(color: tdBlack),
                            decoration: InputDecoration(
                              hintText: 'Add a new task',
                              border: InputBorder.none,
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
                            backgroundColor: isDark ? Colors.white : tdBlue,
                            child: Icon(Icons.add, color: isDark ? tdBlack : Colors.white),

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
  Provider.of<TodoProvider>(context, listen: false).toggleDone(todo);
}

/*------------------------------ Delete ToDos Item --------------------------*/
void _deleteTodoItem(String id){
  Provider.of<TodoProvider>(context, listen: false).deleteTodo(id);
}

/*------------------------------ Create New To Do --------------------------*/
void _addNewToDoItem(String todo){

  if(_textController.text.isNotEmpty) {
      Provider.of<TodoProvider>(context, listen: false).addTodo(todo);
  }
  _textController.clear();
  _focusNode.unfocus();
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
          Provider.of<TodoProvider>(context, listen: false).search(value);
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
      //backgroundColor: tdBgColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

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
