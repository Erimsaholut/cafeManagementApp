import 'package:cafe_management_system_for_camalti_kahvesi/constants/colors.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/write_data_menu.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/custom_divider.dart';
import 'package:flutter/material.dart';
import '../../../datas/menu_data/read_data_menu.dart';
import 'blank_edit_item_page.dart';

class EditItems2 extends StatefulWidget {
  const EditItems2({super.key});

  @override
  State<EditItems2> createState() => _EditItems2State();
}

class _EditItems2State extends State<EditItems2> {
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
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (_, __, ___) => ItemStudio(item: items[index],
                    ),
                    transitionsBuilder: (_, anim, __, child) {
                      return ScaleTransition(
                        scale: anim,
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 300),
                  ),
                );
              },
              child: Text(items[index].name),
            );
          },
        ),
      ),
    );
  }

  /*ilk çalışan*/
/*raw datayı okutup EditableItem(dümdüz class) olarak yaratıyor*/
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

  void saveNewParams() {
    writeData.setExistingItemInMenu(name, price, 0, ingredients);
  }
}
