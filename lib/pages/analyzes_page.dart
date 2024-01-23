import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/reset_table_datas.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';
import 'package:flutter/material.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data.dart';
import '../datas/table_orders_data/read_table_data.dart';

class AnalyzesPage extends StatefulWidget {
  AnalyzesPage({Key? key}) : super(key: key);

/* For now I'm using this page to test data files */
  @override
  State<AnalyzesPage> createState() => _AnalyzesPageState();
}

class _AnalyzesPageState extends State<AnalyzesPage> {
  final ReadData readNewData = ReadData();

  TableDataHandler tableDataHandler = TableDataHandler();

  ResetAllTableJsonData resetAllTableJsonData = ResetAllTableJsonData();

  WriteTableData writeTableData = WriteTableData();

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
      body: ListView(
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
              Map<String, dynamic>? cafeTables =
                  await tableDataHandler.getRawData();
              print(cafeTables);
            },
            child: const Text("test Table item"),
          ),
          TextButton(
            onPressed: () async {
              Map<String, dynamic>? tableData =
                  await tableDataHandler.getTableSet(1);
              print(tableData);
            },
            child: const Text("1 numaralı masanın set datasını çek"),
          ),
          TextButton(
            onPressed: () async {
              resetAllTableJsonData.resetTableJsonFile();
            },
            child: const Text("Resetle table datalarını"),
          ),
          TextButton(
            onPressed: () async {
              await writeTableData.addItemToTable(2, "Çay", 2, 10);
            },
            child: const Text("masa 2 ye yeni çay salla"),
          ),
          TextButton(
            onPressed: () async {
              Map<String, dynamic>? tableData =
                  await tableDataHandler.getTableSet(2);
              print(tableData);
            },
            child: const Text("2 numaralı masanın set datasını çek"),
          ),
          TextButton(
            onPressed: () async {
              await writeTableData.addItemToTable(2, "Yeni Rakı", 1, 100);
            },
            child: const Text("masa 2 ye yeni yeni rakı"),
          ),
        ],
      ),
    );
  }
}
