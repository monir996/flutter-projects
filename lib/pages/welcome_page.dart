import 'package:flutter/material.dart';
import 'package:mini_coffee_shop/pages/home_page.dart';

import '../constant.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/espresso.png', width: 200, color: Colors.brown),
              SizedBox(height: 40),
              Text('Brew Day', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown)),
              SizedBox(height: 10),
              Text('How do you like your coffee?', style: TextStyle(fontSize: 14, color: Colors.brown)),
              SizedBox(height: 40),
              InkWell(
                onTap: () => Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => HomePage())),
                child: Container(
                  padding: EdgeInsets.all(25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.brown[900],
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(child: Text('Enter Shop', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                ),
              )

            ],
          ),
        ),
      ),
    );

  }
}
