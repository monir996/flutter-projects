class Coffee {
  final String name;
  final String price;
  final String imagePath;
  late int quantity;
  late String size;

  Coffee({required this.name, required this.price, required this.imagePath, this.quantity = 1, this.size = 'S'});
}