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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double cardWidth = (screenWidth * 0.33).clamp(70.0, 200.0);

    double? cardHeight = screenHeight < 600 ? null : screenHeight * 0.18;

    double countFontSize = (screenWidth * 0.06).clamp(18.0, 26.0);
    double textFontSize = (screenWidth * 0.045).clamp(14.0, 20.0);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,

        child: Container(
          width: cardWidth,
          height: cardHeight,
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
                Text(count, style: TextStyle(fontSize: countFontSize, fontWeight: FontWeight.bold, color: Colors.white)),
                Text(text, style: TextStyle(fontSize: textFontSize, fontWeight: FontWeight.w500, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}