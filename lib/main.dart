import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_restaurant/models/shop.dart';
import 'package:sushi_restaurant/pages/cart_page.dart';
import '../pages/menu_page.dart';
import '../pages/welcome_page.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Shop())
        ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sushi Restaurant',
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      routes: {
        '/menu' : (context) => MenuPage(),
        '/cart' : (context) => CartPage()
      },
    );
  }
}

