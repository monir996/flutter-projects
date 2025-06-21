import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_restaurant/components/custom_button.dart';
import '../constants/constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // shop name
              Text(
                'SUSHI MAN',
                style: GoogleFonts.dmSerifDisplay(fontSize: 28, color: Colors.white),
              ),
              
              SizedBox(height: 25),

              // icon
              Padding(
                padding: EdgeInsets.all(50),
                child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.asset('assets/images/salmon_eggs.png')
                ),
              ),

              SizedBox(height: 25),

              // title
              Text(
                'THE TASTE OF JAPANESE FOOD',
                style: GoogleFonts.dmSerifDisplay(fontSize: 44, color: Colors.white),
              ),

              SizedBox(height: 10),

              // subtitle
              Text(
                'Feel the taste of the most popular japanese food from anywhere and anytime',
                style: TextStyle(color: Colors.grey[300], height: 2),
              ),

              SizedBox(height: 25),

              // get started button
              CustomButton(
                text: 'Get Started',
                onTap: (){
                  // go to menu page
                  Navigator.pushReplacementNamed(context, '/menu');
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
