import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../screens/home_screen.dart';
import 'data/todo_adapter.dart';

Future<void> main() async {

  /*------------------------- Initiate Hive Database ------------------------*/
  await Hive.initFlutter();

  Hive.registerAdapter(ToDoAdapter()); // Register the adapter
  await Hive.openBox('myBox'); //Open the box

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    /*------------------------------- StatusBar Color ----------------------*/
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: 'Mini ToDo',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

