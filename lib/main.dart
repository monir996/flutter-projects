import 'package:daily_do_with_hive/constants/colors.dart';
import 'package:daily_do_with_hive/pages/settings_page.dart';
import 'package:daily_do_with_hive/provider/theme_provider.dart';
import 'package:daily_do_with_hive/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'adapter/todo_adapter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  /*------------------------- Initiate Hive Database ------------------------*/
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter()); // Register the adapter

  await Hive.openBox('myBox'); //Open the box for To Do List
  await Hive.openBox('settings'); //Box for Theme Settings

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> TodoProvider()),
      ChangeNotifierProvider(create: (_)=> ThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // ------------------------ Theme Provider -----------------
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'DailyDo',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      themeAnimationDuration: Duration.zero,

      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        )
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgColorDark,
        checkboxTheme: CheckboxThemeData(
          side: BorderSide(color: checkBoxBorderColor, width: 2)
        )
      ),

      home: const HomePage(),

      routes: {
        '/settings' : (context) => SettingsPage()
      },
    );
  }
}




