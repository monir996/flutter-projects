import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavBar extends StatelessWidget {

  final onTabChange;
  CustomBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25.0),
      child: GNav(
          mainAxisAlignment: MainAxisAlignment.center,
          color: Colors.grey[400],
          activeColor: Colors.grey[700],
          tabBackgroundColor: Colors.grey.shade300,
          tabBorderRadius: 20,
          tabActiveBorder: Border.all(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

          onTabChange: (value) => onTabChange(value),
          tabs: [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.shopping_bag_outlined, text: "Cart"),
          ]),
    );
  }
}
