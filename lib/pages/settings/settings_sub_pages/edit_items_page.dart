import '../../../constants/custom_colors.dart';
import '../../../constants/styles.dart';
import '../../../datas/menu_data/read_data_menu.dart';
import 'package:flutter/material.dart';
import 'blank_edit_item_page.dart';

class EditItemsPage extends StatefulWidget {
  const EditItemsPage({super.key});

  @override
  State<EditItemsPage> createState() => _EditItemsPageState();
}

class _EditItemsPageState extends State<EditItemsPage> {
  ReadMenuData readData = ReadMenuData();
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
        backgroundColor: CustomColors.appbarColor,
        title: const Text("Edit Items"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: CustomColors.backGroundColor,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 36.0,
            mainAxisSpacing: 36.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: CustomButtonStyles.customMenuItemButtonStyle,
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: true,
                    pageBuilder: (_, __, ___) => ItemStudio(
                      item: items[index],
                      processMenu: () {
                        _processMenuData();
                      },
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
  /* duruma göre stüdyoya gönder bunu resetlesin */

  void processMenuData() {
    _processMenuData();
  }

  Future<void> _processMenuData() async {
    Map<String, dynamic>? rawMenu = await readData.getRawData();
    setState(() {
      items.clear();
      for (var itemData in rawMenu?["menu"]) {
        EditableItem newItem = EditableItem(
          name: itemData["name"],
          price: itemData["price"],
          profit: itemData["profit"],
          ingredients: List<String>.from(itemData["ingredients"]),
          type: itemData["type"],
        );
        items.add(newItem);
      }
      // Alphabetical sorting
      items.sort((a, b) => a.name.compareTo(b.name));
    });
  }
}

class EditableItem {
  String name;
  double price;
  double profit;
  List<String> ingredients;
  String type;

  EditableItem({
    required this.name,
    required this.price,
    required this.profit,
    required this.ingredients,
    required this.type,
  });

  factory EditableItem.fromJson(Map<String, dynamic> json) {
    return EditableItem(
      name: json['name'],
      price: json['price'],
      profit: json['profit'],
      ingredients: List<String>.from(json['ingredients']),
      type: json['type'],
    );
  }

}
