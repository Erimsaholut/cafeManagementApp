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

  @override
  void initState() {
    super.initState();
    _processMenuData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return OutlinedButton(
            onPressed: () {
              _showItemDialog(context, items[index]);
            },
            child: Text(items[index].name),
          );
        },
      ),
    );
  }

  Future<void> _processMenuData() async {
    Map<String, dynamic>? rawMenu = await readMenu();

    setState(() {
      items.clear();
      for (var itemData in rawMenu?["menu"]) {
        EditableItem newItem = EditableItem(
          id: itemData["id"],
          name: itemData["name"],
          price: itemData["price"],
          ingredients: List<String>.from(itemData["ingredients"]),
        );
        items.add(newItem);
      }
    });
  }

  Future<Map<String, dynamic>?> readMenu() {
    return readData.getRawData();
  }

  Future<void> _showItemDialog(BuildContext context, EditableItem item) async {
    double newPrice = item.price;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(item.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: ${item.price}'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () {
                          setState(() {
                            if (newPrice > 0) {
                              newPrice -= 1;
                            }
                          });
                        },
                      ),
                      Text('$newPrice'),
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        onPressed: () {
                          setState(() {
                            newPrice += 1;
                          });
                        },
                      ),
                    ],
                  ),
                  Text('Ingredients: ${indList(item.ingredients)}'),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          items.remove(item);
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Delete'),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          item.price = newPrice;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  String indList(List<String> items) {
    if (items.isEmpty) {
      return "No items";
    }
    return items.join(', ');
  }





}

class EditableItem {
  final int id;
  final String name;
  double price;
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