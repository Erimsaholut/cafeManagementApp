import 'package:flutter/material.dart';
import '../../../datas/menu_data/read_data.dart';

class EditItems extends StatefulWidget {
  const EditItems({Key? key}) : super(key: key);

  @override
  State<EditItems> createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  ReadData readData = ReadData();
  List<EditableItem> items = [];
  List<Widget> itemWidgets = [];

  @override
  void initState() {
    super.initState();
    _processMenuData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              for (var item in items) {
                print(item);
              }
            },
            child: Column(
              children: [
                ...itemWidgets,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>?> readMenu() {
    return readData.getRawData();
  }

  void _processMenuData() async {
    Map<String, dynamic>? rawMenu = await readMenu();

    // Clear existing items
    items.clear();

    // Iterate over the menu items
    for (var itemData in rawMenu?["menu"]) {
      // Create a new EditableItem instance for each item
      EditableItem newItem = EditableItem(
        id: itemData["id"],
        name: itemData["name"],
        price: itemData["price"],
        ingredients: List<String>.from(itemData["ingredients"]),
      );

      // Add the item to the list
      items.add(newItem);
    }

    // Print the items
    for (var item in items) {
      print(item);
    }
    makeItemWidgets(items);
  }

  void makeItemWidgets(List<EditableItem> items) {
    for (var i in items) {
      itemWidgets.add(TextButton(onPressed: () {}, child: Text(i.name)));
    }
  }
}

class EditableItem {
  final int id;
  final String name;
  final double price;
  final List<String> ingredients;

  EditableItem({
    required this.id,
    required this.name,
    required this.price,
    required this.ingredients,
  });

  @override
  String toString() {
    return 'EditableItem{id: $id, name: $name, price: $price, ingredients: $ingredients}';
  }
}
