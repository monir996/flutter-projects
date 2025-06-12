import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mini_todo/constants/colors.dart';
import 'package:mini_todo/provider/theme_provider.dart';
import 'package:mini_todo/provider/todo_provider.dart';
import 'package:provider/provider.dart';
import '../screens/home_screen.dart';
import 'data/todo_adapter.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /*------------------------- Initiate Hive Database ------------------------*/
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter()); // Register the adapter
  await Hive.openBox('myBox'); //Open the box

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TodoProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider())
        ],
        child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    /*------------------------------- StatusBar Color ----------------------*/
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: 'Mini ToDo',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: tdBgColor,
        appBarTheme: AppBarTheme(
          backgroundColor: tdBgColor,
          foregroundColor: Colors.black, // Text, icon color
          elevation: 0,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: tdBlack,
        appBarTheme: AppBarTheme(
          backgroundColor: tdBlack,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      home: HomeScreen(),
    );
  }
}

