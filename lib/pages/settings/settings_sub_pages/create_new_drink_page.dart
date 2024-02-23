import 'package:flutter/material.dart';
import '../../../datas/menu_data/write_data.dart';
import '../../../utils/custom_divider.dart';
import '../settings_page_widgets/custom_text_field.dart';
import '../settings_page_widgets/ingredients.dart';
import '../settings_page_widgets/item_type_selector.dart';
import '../../../utils/price_picker.dart';

class AddNewItemToMenu extends StatefulWidget {
  const AddNewItemToMenu({Key? key}) : super(key: key);

  @override
  _AddNewItemToMenuState createState() => _AddNewItemToMenuState();
}

class _AddNewItemToMenuState extends State<AddNewItemToMenu> {
  final TextEditingController beverageNameController = TextEditingController();
  WriteData writeData = WriteData();
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
                    if(beverageName.isEmpty){
                      scaffoldMessage("Ürün ismi boş olamaz", context);
                    }
                    else{
                      //emin misiniz diye sor ve seçilen bilgileri gönder.
                      writeData.addNewItemToMenu(beverageName,moneyValue, pennyValue, indList, selectedItemType);
                      scaffoldMessage("Yeni ürün başarı ile kaydedildi. $beverageName, $moneyValue, $pennyValue $indList, $selectedItemType", context);
                    }

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

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> scaffoldMessage(
    String message, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
