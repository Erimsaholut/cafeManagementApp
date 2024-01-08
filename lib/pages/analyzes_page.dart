import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_json.dart';
import 'package:flutter/material.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_new_data.dart';

class AnalyzesPage extends StatefulWidget {

  AnalyzesPage({Key? key}) : super(key: key);

  @override
  State<AnalyzesPage> createState() => _AnalyzesPageState();
}

class _AnalyzesPageState extends State<AnalyzesPage> {
  final ReadNewData readNewData = ReadNewData();

  ReadJson readJson = ReadJson();

  bool isMenuSeparated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Analyzes",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              Object menu = (await readNewData.readJsonData()) as Object;
              print(menu);

              // Fonksiyon sadece bir kere çağrılacak şekilde kontrol
              if (!isMenuSeparated) {
                readNewData.separateAndInitData();
                isMenuSeparated = true;
              }

              int menuItemCount = await readNewData.getMenuItemCount();
              print('Menüdeki öğe sayısı: $menuItemCount');
            },
            child: const Text("menuraw + ogeSayisi"),
          ),
          TextButton(
            onPressed: () async {
              print(readJson.getItemCount());
            },
            child: const Text("önceki fonksiyondan getItemCount"),
          ),
          TextButton(
            onPressed: () async {
              if (isMenuSeparated) {
                print("x");
                isMenuSeparated = false;
              }
              setState(() {


              print(isMenuSeparated);
              print(
                  'İçecekler (İçerikli): ${readNewData.drinksWithIngredients}');
              print(
                  'İçecekler (İçeriksiz): ${readNewData.drinksWithNoIngredients}');
              print('Yemekler (İçerikli): ${readNewData.foodsWithIngredients}');
              print(
                  'Yemekler (İçeriksiz): ${readNewData.foodsWithNoIngredients}');
              });
            },
            child: const Text("Olsa Elim Kanda"),
          ),
        ],
      ),
    );
  }
}
