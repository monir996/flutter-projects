import 'package:daily_do_with_hive/constants/colors.dart';
import 'package:daily_do_with_hive/constants/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_bar.dart';
import '../components/dialog_box.dart';
import '../provider/todo_provider.dart';
import '../components/todo_card.dart';
import '../components/todo_tile.dart';
import '../models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showActiveTask = true;

  // ----------- Show Dialog -------

  void _showDialogBox({TodoModel? todo}) {
    final controller = TextEditingController(text: todo?.title ?? '');

    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: controller,
        todo: todo,
        onSave: () {
          final provider = Provider.of<TodoProvider>(context, listen: false);
          final title = controller.text.trim();

          if (todo == null) {
            provider.addTodo(title);
          } else {
            provider.editTodo(todo, title);
          }
          controller.clear();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TodoProvider>(context);
    final filteredTodos = provider.filteredTodos(showActiveTask);

    //final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: Appbar(
        showLogo: showAppBarLogo,
        showAppBarColor: showAppBarBgColor,
        leading: Icon(Icons.menu),
        title: 'DailyDo',
        actions: [
          IconButton(
              onPressed: ()=> Navigator.pushNamed(context, '/settings'),
              icon: Icon(Icons.settings_outlined)
          )

        ]
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showDialogBox,
        backgroundColor: floatingActionBgColor,
        foregroundColor: floatingActionTextColor,
        child: Icon(Icons.add, size: 30,),
      ),

      body: SafeArea(

        child: Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              // Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TodoCard(
                    count: provider.activeCount.toString(),
                    text: 'Active',
                    textColor: todoActiveCardTextColor,
                    color: todoActiveCardColor,
                    onTap: () {
                      setState(() => showActiveTask = true);
                    },
                  ),
                  SizedBox(width: 20),
                  TodoCard(
                    count: provider.completedCount.toString(),
                    text: 'Completed',
                    textColor: todoCompleteCardTextColor,
                    color: todoCompleteCardColor,
                    onTap: () {
                      setState(() => showActiveTask = false);
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),

              // List title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    showActiveTask ? 'Active ToDos' : 'Completed ToDos',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: showActiveTask
                          ? activeToDosTxtColor
                          : completedToDosTxtColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // ToDo List
              Expanded(
                child: filteredTodos.isEmpty
                    ? Center(
                        child: Text(
                          'No ToDos yet.',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(bottom: 50),
                        child: ListView.builder(
                          itemCount: filteredTodos.length,
                          itemBuilder: (context, index) {
                            final todo = filteredTodos[index];
                            return TodoTile(
                              todo: todo,
                              onChanged: () => provider.toggleStatus(todo),
                              onEdit: () => _showDialogBox(todo: todo),
                              onDelete: () => provider.deleteTodo(todo.id),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
