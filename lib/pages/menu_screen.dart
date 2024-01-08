import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';
import '../datas/read_new_data.dart';
import '../utils/custom_button_with_checkboxes.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ReadNewData readNewData = ReadNewData();

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
          style: CustomStyles.menuTextStyle,
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

/*Ekranın ortası yazı sallıyor bu*/
  Container buildItemTypeTextContainer(String text) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: CustomStyles.menuTextStyle,
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
            // Add any additional logic here if needed
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
//todo settings sayfasındaki ayarlar
//todo analiz sayfası ve dışarı aktarabilme özelliği
//todo sipariş alam verme
//todo tasarım
