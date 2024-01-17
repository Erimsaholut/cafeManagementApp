import 'package:flutter/material.dart';
import '../../utils/custom_divider.dart';
import '../settings_page_functions/ingredients.dart';
import '../settings_page_functions/item_type_selector.dart';
import '../settings_page_functions/price_picker.dart';
import '../settings_page_functions/custom_text_field.dart';

class AddNewItemToMenu extends StatefulWidget {
  const AddNewItemToMenu({Key? key}) : super(key: key);

  @override
  _AddNewItemToMenuState createState() => _AddNewItemToMenuState();
}

class _AddNewItemToMenuState extends State<AddNewItemToMenu> {
  final TextEditingController beverageNameController = TextEditingController();
  CustomItemTypeSelector customItemTypeSelector = CustomItemTypeSelector(
    question: 'Ürün tipini seçin',
    option1: 'Yiyecek',
    option2: 'İçecek',
    itemType: "Yiyecek",
  );
  List<String> indList = [];
  int moneyValue = 15;
  int pennyValue = 0;
  late String beverageName;
  String itemType = "Yiyecek";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Menu Item"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        color: Colors.tealAccent,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                buildCustomTextField(
                    "Ürün İsmi", beverageNameController, context),
                customDivider(),
                customItemTypeSelector,
                customDivider(),
                PricePicker(
                  name: "Ürün Fiyatı Belirle",
                  onValueChanged: (int money, int penny) {
                    setState(() {
                      moneyValue = money;
                      pennyValue = penny;
                    });
                  },
                ),
                customDivider(),
                Ingredients(indList: indList),
                customDivider(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    beverageName = beverageNameController.text;
                    print("$beverageName, $moneyValue, $pennyValue");
                    print(indList);

                    String selectedItemType = customItemTypeSelector.itemType;
                    print("Selected Item Type: $selectedItemType");

                    // TODO: Add your validation logic here

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$beverageName, $moneyValue, $pennyValue $indList, $selectedItemType"),
                      ),
                    );
                  },
                  child: const Text("Kaydet"),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
