import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_button.dart';
import '../constants/constants.dart';
import '../models/food.dart';
import '../models/shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // remove from cart
  void removeFromCart(Food food, BuildContext context){
    // get access to the shop
    final shop = context.read<Shop>();

    // remove from cart
    shop.removeFromCart(food);
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<Shop>(builder: (context, value, child) => SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,

        appBar: AppBar(
          title: Text('My Cart'),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),

        body: Column(
          children: [

            // customer cart
            Expanded(
              child: ListView.builder(
                  itemCount: value.cart.length,
                  itemBuilder: (context, index){

                    // get food from cart
                    final Food food = value.cart[index];

                    // get food name
                    final String foodName = food.name;

                    // get food price
                    final String foodPrice = food.price;

                    // return list tile
                    return Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      margin: EdgeInsets.only(left: 20, top: 20, right: 20),

                      child: ListTile(
                        title: Text(foodName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),

                        subtitle: Text(foodPrice, style: TextStyle(color: Colors.grey[200])),

                        trailing: IconButton(
                            onPressed: ()=> removeFromCart(food, context),
                            icon: Icon(Icons.delete),
                            color: Colors.grey[300],
                        ),
                      ),
                    );
                  }
              ),
            ),

            // pay button
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: CustomButton(text: 'Pay Now', onTap: (){}),
            )
          ],
        ),
      ),
    )
    );
  }
}
