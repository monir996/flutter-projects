import 'package:flutter/material.dart';
import 'package:sushi_restaurant/constants/constants.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final void Function()? onTap;

  CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(40)
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // text
            Text(text, style: TextStyle(color: Colors.white)),

            SizedBox(width: 10),
            // icon
            Icon(Icons.arrow_forward, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
