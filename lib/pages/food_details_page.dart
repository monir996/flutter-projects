import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/custom_button.dart';
import '../constants/constants.dart';
import '../models/food.dart';
import '../models/shop.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;
  const FoodDetailsPage({super.key, required this.food});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {

  // quantity count
  int quantityCount = 1;

  // quantity decrement
  void decrementQuantity() {
    setState(() {
      if(quantityCount > 1) {
        quantityCount--;
      }
    });
  }

  // quantity increment
  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  // add to cart
  void addToCart(){
    final shop = context.read<Shop>();

    shop.addToCart(widget.food, quantityCount);

    // let the user know it was added successful
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: primaryColor,
          content: Text(
            'Successfully added to cart.',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: [
            // ok button
            IconButton(
                onPressed: (){
                  // pop once to remove dialog box
                  Navigator.pop(context);

                  // pop again to go to previous screen
                  Navigator.pop(context);
                },
                icon: Icon(Icons.done, color: Colors.white,)
            )
          ],
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Column(
        children: [
          // listview of food details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  // image
                  Image.asset(widget.food.imagePath, height: 200),

                  SizedBox(height: 25),

                  // rating
                  Row(
                    children: [
                      // star icon
                      Icon(Icons.star, color: Colors.yellow[800]),

                      SizedBox(width: 5),

                      // rating number
                      Text(
                        widget.food.rating,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // food name
                  Text(
                    widget.food.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),

                  SizedBox(height: 25),

                  // description
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Delicately sliced, fresh Atlantic salmon drapes elegantly over a '
                        'pillow of perfectly seasoned sushi rice. Its vibrant hue and '
                        'buttery texture promise an exquisite melt-in-your-mouth experience.'
                        ' Paired with a whisper of wasabi and a side of traditional pickled '
                        'ginger, our salmon sushi is an ode to the purity and simplicity of'
                        ' authentic Japanese flavors. Indulge in the ocean’s bounty with each '
                        'savory bite.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 2
                    ),
                  ),
                ],
              ),
            ),
          ),

          // price + quantity + add to cart button
          Container(
            color: primaryColor,
            padding: EdgeInsets.all(25),
            child: Column(
              children: [

                // price + quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // price
                    Text(
                      widget.food.price,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    // quantity
                    Row(
                      children: [
                        // minus button
                        Container(
                          decoration: BoxDecoration(color: secondaryColor, shape: BoxShape.circle),
                          child: IconButton(
                              onPressed: decrementQuantity,
                              icon: Icon(Icons.remove),
                              color: Colors.white,
                          ),
                        ),

                        // quantity count
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              quantityCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),

                        // plus button
                        Container(
                          decoration: BoxDecoration(color: secondaryColor, shape: BoxShape.circle),
                          child: IconButton(
                            onPressed: incrementQuantity,
                            icon: Icon(Icons.add),
                            color: Colors.white,
                          ),
                        ),

                      ],
                    )

                  ],
                ),

                SizedBox(height: 25,),

                // add to cart button
                CustomButton(text: 'Add To Cart', onTap: addToCart)
              ],
            ),
          )
        ],
      ),
    );
  }
}
