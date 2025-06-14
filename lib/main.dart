import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';
import '../constants/colors.dart';
import '../provider/theme_provider.dart';
import '../provider/todo_provider.dart';
import '../screens/about_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/home_screen.dart';
import '../data/todo_adapter.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /*------------------------- Initiate Hive Database ------------------------*/
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter()); // Register the adapter

  await Hive.openBox('myBox'); //Open the box for To Do List
  await Hive.openBox('settings'); // for theme settings


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

      //theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: tdBgColor,
        appBarTheme: AppBarTheme(
          backgroundColor: tdBgColor,
          foregroundColor: tdBlack, // Text, icon color
          elevation: 0,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: tdBlack,
        appBarTheme: AppBarTheme(
          backgroundColor: tdBlack,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      home: HomeScreen(),

      routes: {
        '/about' : (context) => AboutScreen(),
        '/settings' : (context) => SettingsScreen(),
      },
    );
  }
}

