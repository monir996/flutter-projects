import 'package:flutter/material.dart';
import '../components/coffee_tile.dart';
import '../models/coffee.dart';
import '../models/coffee_shop.dart';
import 'package:provider/provider.dart';
import 'item_details_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  @override
  Widget build(BuildContext context) {

    return Consumer<CoffeeShop>(
        builder: (context, value, child) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Heading Message
                Text('How would you like your coffee?', style: TextStyle(fontSize: 20.0), ),

                SizedBox(height: 25),

                //list of coffee to buy
                Expanded(
                    child: ListView.builder(
                        itemCount: value.coffeeShopList.length,
                        itemBuilder: (context, index) {

                          //Get individual coffee
                          Coffee eachCoffee = value.coffeeShopList[index];

                          //Return the Tile for this coffee
                          return CoffeeTile(
                              coffee: eachCoffee,
                              icon: Icon(Icons.arrow_forward),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetailsPage(coffee: eachCoffee),
                                  ),
                                );
                              }
                          );
                        }
                    )
                )
              ],
            ),
          ),
        )
    );

  }
}
