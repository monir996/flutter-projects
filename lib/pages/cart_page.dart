import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/coffee_tile.dart';
import '../models/coffee.dart';
import '../models/coffee_shop.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  //Remove Item from Cart
  void removeFromCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).removeItemFromCart(coffee);
  }

  //Pay Button Tapped
  void payNow(){
    //Add payment method here
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<CoffeeShop>(
          builder: (context, value, child) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [

                  //Heading Message
                  Text('Your Cart', style: TextStyle(fontSize: 20.0),),

                  SizedBox(height: 25),

                  //list of coffee to buy
                  Expanded(
                      child: ListView.builder(
                          itemCount: value.userCart.length,
                          itemBuilder: (context, index) {

                            //Get individual coffee
                            Coffee eachCoffee = value.userCart[index];

                            //Return the Tile
                            return CoffeeTile(
                              coffee: eachCoffee,
                              icon: Icon(Icons.delete),
                              onPressed: () => removeFromCart(eachCoffee),
                            );
                          }
                      )
                  ),

                  //Pay button

                  value.userCart.isNotEmpty ?
                  GestureDetector(
                    onTap: payNow,
                    child: Container(
                      padding: EdgeInsets.all(25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(child: Text('Pay now', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                    ),
                  )
                  : SizedBox.shrink() // Empty Widget, Hides the button when the list is empty

                ],
              ),
            ),
          )
      );
  }
}
