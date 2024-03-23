import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/price_picker.dart';
import '../../../constants/styles.dart';
import 'package:flutter/material.dart';
import 'EditItems2.dart';

class ItemStudio extends StatefulWidget {
  const ItemStudio({super.key, required this.item});

  final EditableItem item;

  @override
  State<ItemStudio> createState() => _ItemStudioState();
}

class _ItemStudioState extends State<ItemStudio> {
  List<EditableItem> items = []; // Burada items listesini tanımladık.

  @override
  void initState() {
    _processMenuData(); // initState içinde _processMenuData'yı çağırdık.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int moneyValue = 0;
    int pennyValue = 0;

    return Scaffold(
        backgroundColor: Colors.lime.shade300,
        appBar: AppBar(
          title: Text("Edit  ${widget.item.name}"),
          backgroundColor: Colors.orangeAccent,
        ),
        body: ListView(
          children: [
            Column(
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
                const Text("Çeşitler"),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    ...(indList(widget.item)),
                  ],
                )
              ],
            ),
          ],
        ));
  }

  List<Widget> indList(EditableItem editableItem) {
    List<Widget> indWidgetList = [];
    Size screenSize = MediaQuery.of(context).size;
    if (editableItem.ingredients.isEmpty) {
      indWidgetList.add(const Text("No ingredient"));
    } else {
      for (var i = 0; i < editableItem.ingredients.length; i++) {
        indWidgetList.add(SizedBox(
          width: screenSize.width / 3,
          child: TextButton(
            onPressed: () {
              editableItem.ingredients.removeAt(i);
              setState(() {}); // Durumu güncellemek için setState ekledik.
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Colors.red.shade300;
                },
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    editableItem.ingredients[i],
                    style: CustomStyles.blackTextStyleS,
                  ),
                  const Icon(Icons.close)
                ],
              ),
            ),
          ),
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

  /*ilk çalışan*/
  /*raw datayı okutup EditableItem(dümdüz class) olarak yaratıyor*/
  Future<void> _processMenuData() async {
    ReadData readData = ReadData();
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
