import 'package:cafe_management_system_for_camalti_kahvesi/constants/colors.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/write_data_menu.dart';
import 'package:flutter/material.dart';
import '../../../datas/menu_data/read_data_menu.dart';

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
        backgroundColor: CustomColors.appbarBlue,
        title: const Text("Edit Items"),
      ),
      body: Container(
        color: Colors.tealAccent,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 36.0,
            mainAxisSpacing: 36.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0), // Kare şeklini ayarlamak için 0.0 olarak belirleyin.
                  ),
                ),
              ),
              onPressed: () {
                _showItemDialog(context, items[index]);
              },
              child: Text(items[index].name),
            );

          },
        ),
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

                        setState((){
                          Navigator.of(context).pop();
                        });

                      },
                      child: Text('Close'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          item.price = newPrice;
                          print(item.toString());
                          item.saveNewParams();
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
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
    if (editableItem.ingredients.isEmpty) {
      indWidgetList.add(const Text("No ingredient"));
    } else {
      for (var i = 0; i < editableItem.ingredients.length; i++) {
        indWidgetList.add(Row(
          children: [
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return Colors.red.shade300;
                    },
                  ),
                ),
                onPressed: () {
                  setState(() {
                    editableItem.ingredients.removeAt(i);
                  });
                },
                child: Text(
                  editableItem.ingredients[i],
                  style: CustomStyles.blackTextStyleS,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  editableItem.ingredients.removeAt(i);
                  Navigator.pop(context);
                  _showItemDialog(context, editableItem);
                });
              },
            ),
          ],
        ));
      }
    }

    if (indWidgetList.isEmpty) {
      indWidgetList.add(const Text("No ingredient"));
    }

    indWidgetList.add(const SizedBox(
      height: 10,
    ));

    return indWidgetList;
  }

}

/*bu bizim aslan parçası classımız*/
class EditableItem {
  WriteData writeData = WriteData();
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

  void saveNewParams(){
writeData.setExistingItemInMenu(name, price, 0, ingredients);

  }
}
