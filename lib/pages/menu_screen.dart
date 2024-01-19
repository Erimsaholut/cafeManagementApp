import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';
import '../datas/menu_data/read_data.dart';
import '../utils/custom_button_with_checkboxes.dart';

/*itemlerin seçilip eklendiği o sayfa*/


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ReadData readNewData = ReadData();

  List<Widget> drinksNoIn = [];

  List<Widget> drinksIn = [];

  List<Widget> foodsNoIn = [];

  List<Widget> foodsIn = [];

  @override
  void initState() {
    super.initState();
    createButtons();
  }

  void createButtons() {
    setState(() {
      makeWidgetsForNoInd(readNewData.drinksWithNoIngredients, drinksNoIn);
      makeWidgetsForInd(readNewData.drinksWithIngredients, drinksIn);

      makeWidgetsForNoInd(readNewData.foodsWithNoIngredients, foodsNoIn);
      makeWidgetsForInd(readNewData.foodsWithIngredients, foodsIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menü",
          style: CustomStyles.blackAndBoldTextStyleXl,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.blueGrey,
        child: ListView(
          children: [
            buildItemTypeTextContainer("İçecekler"), //içecekler
            buildGridView(drinksNoIn),
            ...drinksIn,

            buildItemTypeTextContainer("Yiyecekler"), //yiyecekler
            buildGridView(foodsNoIn),
            ...foodsIn,
          ],
        ),
      ),
    );
  }

  Container buildItemTypeTextContainer(String text) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: CustomStyles.blackAndBoldTextStyleXl,
      ),
    );
  }

  void makeWidgetsForNoInd(List<String> items, List<Widget> widgets) {
    for (var item in items) {
      widgets.add(
        TextButton(
          style: CustomStyles.customMenuItemButtonStyle,
          onPressed: () {
            if (kDebugMode) {
              print(item);
            }
          },
          child: Text(item),
        ),
      );
    }
  }

  void makeWidgetsForInd(
      List<Map<String, dynamic>> items, List<Widget> widgets) {
    for (var item in items) {
      List<String> ingredients = List<String>.from(item["ingredients"]);

      widgets.add(
        MyCustomButton(
          buttonText: item["name"],
          checkboxTexts: ingredients,
          onPressed: () {
            if (kDebugMode) {
              print("Button pressed for ${item["name"]}");
            }
            // ekleme buraya gelecek
          },
        ),
      );
    }
  }

  Widget buildGridView(List<Widget> list) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 32.0,
        mainAxisSpacing: 32.0,
      ),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return list[index];
      },
    );
  }
}
//todo only one checkboxlu customWidget
//todo analiz sayfası ve dışarı aktarabilme özelliği
//todo tasarım
//todo firebase (dlc olarak sunucam onu)
//todo menüye item ekle bitir
//todo sipariş ödeme ekranı hallet
//todo bi tane genel emin misiniz widgetı oluştur resetleme ve ürün eklemeye koy her yere koy
