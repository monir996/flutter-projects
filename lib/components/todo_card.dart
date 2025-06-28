import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {

  Color color;
  Color textColor;
  String count;
  String text;
  VoidCallback onTap;

  TodoCard({
    super.key,
    required this.color,
    required this.textColor,
    required this.count,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
            Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: textColor)),
          ],
        ),
      ),
    );
  }
}