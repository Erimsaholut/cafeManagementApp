import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_colors.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import '../../../datas/menu_data/read_data_menu.dart';
import 'package:flutter/material.dart';
import 'blank_edit_item_page.dart';

class EditItemsPage extends StatefulWidget {
  const EditItemsPage({super.key});

  @override
  State<EditItemsPage> createState() => _EditItemsPageState();
}

class _EditItemsPageState extends State<EditItemsPage> {
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

}
//todo buraya profit hesaplayıcı gelecek