import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/reset_table_datas.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/reset_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/write_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data_menu.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/custom_alert_button.dart';
import '../datas/table_orders_data/read_table_data.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  AdminPanel({Key? key}) : super(key: key);

/* For now I'm using this page to test data files */
  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final ReadData readNewData = ReadData();

  TableReader tableDataHandler = TableReader();

  ResetAllTableJsonData resetAllTableJsonData = ResetAllTableJsonData();

  WriteTableData writeTableData = WriteTableData();

  WriteAnalysesData writeAnalysesData = WriteAnalysesData();

  AnalysesReader analysesReader = AnalysesReader();
  ResetAllAnalysesJsonData resetAllAnalysesJsonData =
      ResetAllAnalysesJsonData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admin Panel",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView(
        children: [
          Container(color: Colors.red,child: SizedBox(width: 20,height: 20,),),
          TextButton(onPressed: (){}, child: Text("Reset Everything")),
          Container(color: Colors.red,child: SizedBox(width: 20,height: 20,),),
          TextButton(
            onPressed: () async {
              DateTime now = DateTime.now();
              Map<String, dynamic>? monthlySales = await analysesReader.getWeeklyTotalRevenueForMonth(now.month, now.year);
              print(monthlySales);
            },
            child: Text("Aylık kazanç salla her hafta"),
          ),

          TextButton(
            onPressed: () async {
              DateTime now = DateTime.now();
              Map<String, double>? monthlySales = await analysesReader.getDailyTotalRevenueForMonth(now.month, now.year);
              print(monthlySales);
            },
            child: Text("Aylık kazanç salla her gün"),
          ),

          TextButton(
            onPressed: () async {
              DateTime now = DateTime.now();
              int month = now.month; // Mevcut ay
              int year = now.year; // Mevcut yıl

              Map<int, Map<String, int>>? monthlySales =
                  await analysesReader.getWeeklyProductSalesForMonth(month, year);
              if (monthlySales != null) {
                // Sonuçları yazdır

                monthlySales.forEach((week, sales) {
                  print('Hafta $week Satışları:');
                  sales.forEach((product, quantity) {
                    print('$product: $quantity');
                  });
                });
                print("#############");
                print(monthlySales);
              } else {

              }
            },
            child: Text("Aylık Satış Verilerini Getir"),
          ),
          TextButton(
            onPressed: () async {
              DateTime now = DateTime.now();
              Future<Map<String, dynamic>?> analysesFuture =
                  analysesReader.getDaySet(now.day, now.month, now.year);
              analysesFuture.then((analyses) {
                if (analyses != null) {
                  print("Bugünkü analizler: $analyses");
                  // Analiz verilerini kullanabilirsiniz
                  Future<double> totalRevenueFuture = analysesReader
                      .getDaysTotalRevenue(now.day, now.month, now.year);
                  totalRevenueFuture.then((totalRevenue) {
                    print("Bugünün toplam geliri: $totalRevenue");
                  });
                } else {
                  print("Bugünkü analizler bulunamadı.");
                }
              });
            },
            child: Text("Bugünün analizlerini al"),
          ),
          TextButton(
            onPressed: () {
              DateTime now = DateTime.now();

              print("${now.day}.${now.month}.${now.year}");
              print(now.day);
            },
            child: Text("Date"),
          ),
          TextButton(
            onPressed: () async {
              Object analysesRaw =
                  (await analysesReader.getRawData()) as Object;
              print(analysesRaw);
            },
            child: const Text("show dates"),
          ),
          TextButton(
            onPressed: () async {
              resetAllAnalysesJsonData.resetAllTableJsonFiles();
            },
            child: const Text("Reset all the analyses data"),
          ),
          TextButton(
            onPressed: () async {
              resetAllAnalysesJsonData.loadExampleJsonData();
            },
            child: const Text("LoadExampleJsonData"),
          ),

          Container(color: Colors.red,child: SizedBox(width: 20,height: 20,),),

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
          Container(color: Colors.red,child: SizedBox(width: 20,height: 20,),),
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
              resetAllTableJsonData.resetAllTableJsonFiles();
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
          TextButton(
            onPressed: () async {
              await writeTableData.addItemToTable(2, "Kırmızı Tuborg", 2, 75);
            },
            child: const Text("masa 2 ye kırmızı tuborg"),
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertButton(
                    text1: 'Test Edilecektir.',
                    text2: 'Emin misiniz ?',
                    customFunction: () {
                      print("object");
                    },
                  ); // Burada const kullanmamalısınız
                },
              );
            },
            child: const Text("customAlert"),
          ),
        ],
      ),
    );
  }
}
