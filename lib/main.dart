import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mini_coffee_shop/models/coffee_shop.dart';
import 'package:mini_coffee_shop/pages/welcome_page.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /*----------------------- Transparent StatusBar Color --------------------------------*/
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark
  ));

  /*
   Enable edge-to-edge layout so that app content can render behind the status bar and navigation bar.
   Useful for creating immersive UI with transparent status bar or fullscreen background images.
   if content goes behind the status bar and bottom bar then use SafeArea
  */

  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  /*----------------------- Splash --------------------------------*/

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 3));
  FlutterNativeSplash.remove();


  runApp(
    ChangeNotifierProvider(create: (_) => CoffeeShop(), child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Mini Coffee Shop',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

