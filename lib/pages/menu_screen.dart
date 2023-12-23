import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';
import '../datas/prepareData.dart';
import '../testButton.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final PrepareData preparedData = PrepareData();

  List<Widget> drinksNoIn = [];

  List<Widget> drinksIn = [];

  List<Widget> foodsNoIn = [];

  List<Widget> foodsIn = [];

  @override
  void initState() {
    super.initState();
    preparedData.initializeData();
    test();
  }

  void test() {
    setState(() {
      makeWidgetsForNoInd(preparedData.getDrinksWithNoIngredients(), drinksNoIn);
      makeWidgetsForInd(preparedData.getDrinksWithIngredients(), drinksIn);

      makeWidgetsForNoInd(preparedData.getFoodsWithNoIngredients(), foodsNoIn);
      makeWidgetsForInd(preparedData.getFoodsWithIngredients(), foodsIn);

      print(preparedData.getDrinksWithIngredients());
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
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.blueGrey,
        child: ListView(
          children: [
            buildItemTypeTextContainer("İçecekler"), //içecekler
            ...drinksNoIn,
            ...drinksIn,

            buildItemTypeTextContainer("Yiyecekler"), //yiyecekler
            ...foodsNoIn,
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
            onPressed: () {
              if (kDebugMode) {
                print(item);
              }
            },
            child: Text(item)),
      );
    }
  }
}
void makeWidgetsForInd(List<Map<String, dynamic>> items, List<Widget> widgets) {
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