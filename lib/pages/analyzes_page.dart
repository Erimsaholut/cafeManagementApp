import 'package:flutter/material.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data.dart';
import '../datas/table_orders_data/read_table_data.dart';

class AnalyzesPage extends StatefulWidget {
  AnalyzesPage({Key? key}) : super(key: key);

  @override
  State<AnalyzesPage> createState() => _AnalyzesPageState();
}

class _AnalyzesPageState extends State<AnalyzesPage> {
  final ReadData readNewData = ReadData();

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
              int menuItemCount = await readNewData.getMenuItemCount();
              print('Menüdeki öğe sayısı: $menuItemCount');
            },
            child: const Text("menuraw + ogeSayisi"),
          ),
          TextButton(
            onPressed: () async {
              setState(() {
                print(
                    'İçecekler (İçerikli): ${readNewData.drinksWithIngredients}');
                print(
                    'İçecekler (İçeriksiz): ${readNewData.drinksWithNoIngredients}');
                print(
                    'Yemekler (İçerikli): ${readNewData.foodsWithIngredients}');
                print(
                    'Yemekler (İçeriksiz): ${readNewData.foodsWithNoIngredients}');
              });
            },
            child: const Text("separeted menu items"),
          ),
          TextButton(
            onPressed: () async {
              String? cafeName = await readNewData.getCafeName();
              print(cafeName);
            },
            child: const Text("sadece kafe ismi"),
          ),
          TextButton(
            onPressed: () async {
              try {
                TableDataHandler readTableData = TableDataHandler();
                Map<String, dynamic>? tableData =
                    await readTableData.getRawData();
                if (tableData != null) {
                  print("Table data read successfully:");
                  print(tableData);
                } else {
                  print("Table data is null or couldn't be read.");
                }
              } catch (e) {
                print("Error reading table data: $e");
              }
            },
            child: Text("test Table item"),
          ),

        ],
      ),
    );
  }
}
