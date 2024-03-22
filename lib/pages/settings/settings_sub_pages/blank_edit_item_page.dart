import 'package:flutter/material.dart';

import '../../../utils/price_picker.dart';

class ItemStudio extends StatefulWidget {
  const ItemStudio({super.key,required this.itemName, required this.price, required this.ingredients});
  final String itemName;
  final double price;
  final List<String> ingredients;

  @override
  State<ItemStudio> createState() => _ItemStudioState();
}

class _ItemStudioState extends State<ItemStudio> {
  @override
  Widget build(BuildContext context) {
    int moneyValue = 15;
    int pennyValue = 0;
    return Scaffold(
      backgroundColor: Colors.lime.shade300,
      appBar: AppBar(title: Text("Edit${widget.itemName}"),backgroundColor: Colors.orangeAccent,),
      body: Column(
        children: [
          PricePicker(
            name: "Ürün Fiyatı Belirle",
            onValueChanged: (int money, int penny) {
              setState(() {
                moneyValue = money;
                pennyValue = penny;
              });
            },
          ),
        ],
      )
    );
  }
}
