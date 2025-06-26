import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {

  Color color;
  String count;
  String text;
  VoidCallback onTap;

  TodoCard({
    super.key,
    required this.color,
    required this.count,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: color,

      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 150,
          padding: EdgeInsets.all(16),
          
          child: Column(
            children: [
              Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
