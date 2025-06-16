import 'package:flutter/material.dart';
import 'package:mini_coffee_shop/models/coffee.dart';

class CoffeeShop extends ChangeNotifier {

  //Coffee for sale list
  final List<Coffee> _shop = [

    //black coffee
    Coffee(name: 'Long Black', price: '\$4.10', imagePath: "assets/images/black.png"),

    //latte
    Coffee(name: 'Latte', price: '\$4.20', imagePath: "assets/images/latte.png"),

    //espresso
    Coffee(name: 'Espresso ', price: '\$3.50', imagePath: "assets/images/espresso.png"),

    //ice-coffee
    Coffee(name: 'Iced Coffee', price: '\$4.40', imagePath: "assets/images/iced_coffee.png"),
  ];

  //User Cart
  List<Coffee> _userCart = [];

  //Get Coffee list
  List<Coffee> get coffeeShopList => _shop;

  //Get User Cart
  List<Coffee> get userCart => _userCart;

  //Add item to cart
  void addItemToCart(Coffee coffee) {
    userCart.add(coffee);
    notifyListeners();
  }

  //Remove item from cart
  void removeItemFromCart(Coffee coffee) {
    userCart.remove(coffee);
    notifyListeners();
  }

  //increase quantity
  void increaseQuantity(Coffee coffee) {
    coffee.quantity++;
    notifyListeners();
  }

  //decrease quantity
  void decreaseQuantity(Coffee coffee) {
    if (coffee.quantity > 1) {
      coffee.quantity--;
      notifyListeners();
    }
  }

  //size
  void setSize(Coffee coffee, String newSize) {
    coffee.size = newSize;
    notifyListeners();
  }

}