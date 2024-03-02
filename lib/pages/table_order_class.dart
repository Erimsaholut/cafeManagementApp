class TableOrderClass {
  final String name;
  final double price;
  final int quantity;

  TableOrderClass(
      {required this.name, required this.price, required this.quantity});

  @override
  String toString() {
    return 'Name: $name, Price: $price, Quantity: $quantity';
  }
}