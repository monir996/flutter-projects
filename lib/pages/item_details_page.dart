import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/coffee.dart';
import '../models/coffee_shop.dart';

class ItemDetailsPage extends StatelessWidget {

  final Coffee coffee;

  const ItemDetailsPage({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {

    final shop = Provider.of<CoffeeShop>(context);

    //Add Coffee to cart
    void addToCart(Coffee coffee) {

      //add to cart
      Provider.of<CoffeeShop>(context, listen: false).addItemToCart(coffee);

      //let user know it add been successfully added
      DelightToastBar(
          builder: (context) {
            return const ToastCard(
                leading: Icon(Icons.notifications_active, size: 32, color: Colors.white,),
                title: Text(
                    "Successfully added to cart",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white)),
                color: Colors.brown,
            );
          },
          position: DelightSnackbarPosition.top,
          autoDismiss: true,
          snackbarDuration: Duration(milliseconds: 3000)
      ).show(context);

    }


    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(coffee.imagePath, width: 120),

            const SizedBox(height: 20),

            const Text(
              'QUANTITY',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                letterSpacing: 3,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            // Quantity selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Minus button
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.brown),
                  onPressed: () {
                    if (coffee.quantity > 1) {
                      shop.decreaseQuantity(coffee);
                    }
                  },
                ),

                // Quantity display in white box
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    coffee.quantity.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                // Plus button
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.brown),
                  onPressed: () {
                    shop.increaseQuantity(coffee);
                  },
                ),
              ],
            ),


            const SizedBox(height: 30),

            Text(
              'SIZE',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                letterSpacing: 3,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            // Size selector buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['S', 'M', 'L'].map((s) {
                bool selected = coffee.size == s;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      shop.setSize(coffee, s);
                    },
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selected ? Colors.brown : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.brown),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        s,
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 40),
            // Add to cart button

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                      // Add your cart logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                  child: InkWell(
                    onTap: () {
                      addToCart(coffee);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Add to cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }


}
