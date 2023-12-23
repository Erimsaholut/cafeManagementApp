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
      makeWidgets(
          preparedData.getDrinksWithIngredients(), drinksIn, "drink", 1);
      makeWidgets(
          preparedData.getDrinksWithNoIngredients(), drinksNoIn, "drink", 0);
      makeWidgets(preparedData.getFoodsWithIngredients(), foodsIn, "food", 1);
      makeWidgets(
          preparedData.getFoodsWithNoIngredients(), foodsNoIn, "food", 0);
      //todo buraya gerekli widget çeviricileri gelecek;
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

  void makeWidgets(
      List<String> items, List<Widget> widgets, String itemType, int hasInd) {
    for (var item in items) {
      widgets.add(
        TextButton(
            onPressed: () {
              print(item);
            },
            child: Text(item)),
      );
    }
  }
}

