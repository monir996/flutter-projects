import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/shop.dart';
import '../pages/food_details_page.dart';
import '../components/custom_button.dart';
import '../components/food_tile.dart';
import '../constants/constants.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {


  // navigate to food item details page
  void navigateToFoodDetails(int index){

    // get the shop and it's menu
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;

    Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailsPage(
        food: foodMenu[index]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    // get the shop and it's menu
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;

    return Scaffold(
      backgroundColor: menuBgColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Tokyo'),
        centerTitle: true,
        
        actions: [
          //cart button
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/cart');
              },
              icon: Icon(Icons.shopping_cart)
          )
        ],
      ),

      drawer: Drawer(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // promo banner
          Container(
            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.symmetric(horizontal: 25),
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // promo message
                    Text(
                        'Get 32% Promo',
                        style: GoogleFonts.dmSerifDisplay(fontSize: 20, color: Colors.white),
                    ),

                    SizedBox(height: 20),

                    // redeem button
                    CustomButton(text: 'Redeem', onTap: (){}),
                  ],
                ),

                // image
                Image.asset('assets/images/many_sushi.png', height: 100)
              ],
            ),
          ),

          SizedBox(height: 25),

          // search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)
                ),

                hintText: 'Search here..'
              ),
            ),
          ),

          SizedBox(height: 25),

          // menu list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Food Menu',
              style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
          ),

          SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodMenu.length,
              itemBuilder: (context, index) => FoodTile(
                food: foodMenu[index],
                onTap: () => navigateToFoodDetails(index),
              ),
            ),
          ),

          SizedBox(height: 25),

          // popular food
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20)
            ),
            margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    // image
                    Image.asset('assets/images/salmon_eggs.png', height: 60,),

                    SizedBox(width: 20),

                    // name + price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name
                        Text('Salmon Eggs', style: GoogleFonts.dmSerifDisplay(fontSize: 18),),

                        SizedBox(height: 10),

                        // price
                        Text('\$21.00', style: TextStyle(color: Colors.grey[700]))
                      ],
                    ),
                  ],
                ),

                // heart icon
                Icon(Icons.favorite_outline, color: Colors.grey, size: 28,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
