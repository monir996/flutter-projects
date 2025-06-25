import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  String count, text;
  Color color;
  final onTap;

  CardWidget({
    super.key,
    required this.count,
    required this.text,
    required this.color,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,

        child: Container(
          width: 200,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)]
          ),

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}