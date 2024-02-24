import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
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

/*raw datayı okutup EditableItem olarak yaratıyor*/
  Future<void> _processMenuData() async {
    Map<String, dynamic>? rawMenu = await readData.getRawData();

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



  /* her item için üzerine tıklandığında açılan pencereyi yaratıyor*/
  Future<void> _showItemDialog(BuildContext context, EditableItem item) async {
    double newPrice = item.price;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(child: Text(item.name)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Price'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    const Text('Ingredients:'),
                    ...(indList(item)),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            items.remove(item);
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('Delete Item'),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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


  /*Elimizdeki ind stringlerini butona çeviriyor*/
  List<Widget> indList(EditableItem editableItem) {
    List<Widget> indWidgetList = [];
    if (items.isEmpty) {
      indWidgetList.add(const Text("No items"));
    } else {
      indWidgetList.add(Text("Tap to Remove item",style: TextStyle(color: Colors.black.withOpacity(0.3)),));


      for (var i in editableItem.ingredients) {
        indWidgetList.add(TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.redAccent;
                  }
                  return Colors.red.shade300;
                },
              ),
            ),
            onPressed: () {
            },
            child: Text(
              i,
              style: CustomStyles.blackTextStyleS,
            )));
      }


    }

    indWidgetList.add(const SizedBox(height: 10,));
    indWidgetList.add(TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.transparent;
              }
              return Colors.green.shade400;
            },
          ),
        ),
        onPressed: () {

        },
        child: Text("Add ingredient",style: CustomStyles.blackTextStyleS,)));

    return indWidgetList;
  }



}

/*bu bizim aslan parçası classımız*/
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
