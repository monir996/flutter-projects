import 'package:flutter/material.dart';
import 'package:mini_coffee_shop/models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  final onPressed;
  final Widget icon;

  const CoffeeTile({super.key, required this.coffee, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),

      child: ListTile(
        leading: Image.asset(coffee.imagePath),
        title: Text(coffee.name),
        subtitle: Text(coffee.price),
        trailing: IconButton(
            onPressed: onPressed,
            icon: icon
          )
        ),
      );
  }
}
