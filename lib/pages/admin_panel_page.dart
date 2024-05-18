import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/reset_table_datas.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/reset_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/write_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/read_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data_menu.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/custom_alert_button.dart';
import '../constants/custom_colors.dart';
import '../datas/menu_data/reset_datas_menu.dart';
import '../datas/table_orders_data/read_table_data.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final ReadMenuData readNewData = ReadMenuData();

  TableReader tableDataHandler = TableReader();

  ResetAllTableJsonData resetAllTableJsonData = ResetAllTableJsonData();

  WriteTableData writeTableData = WriteTableData();

  ResetAllJsonData resetAllJsonData = ResetAllJsonData();

  WriteAnalysesData writeAnalysesData = WriteAnalysesData();

  AnalysesReader analysesReader = AnalysesReader();
  ResetAllAnalysesJsonData resetAllAnalysesJsonData =
      ResetAllAnalysesJsonData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Panel",
          style: CustomTextStyles.blackAndBoldTextStyleM,
        ),
        backgroundColor: CustomColors.backGroundColor,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.red,
            child: const SizedBox(
              width: 20,
              height: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () async {
                    resetAllJsonData.resetMenuToDemo();
                  },
                  child: const Text("Reset demo menu")),
              TextButton(
                  onPressed: () async {
                    resetAllJsonData.resetMenuToBlank();
                  },
                  child: const Text("Delete Menu")),
            ],
          ),
          Container(
            color: Colors.red,
            child: const SizedBox(
              width: 20,
              height: 20,
            ),
          ),
          TextButton(
            onPressed: () async {
              DateTime now = DateTime.now();
              Map<String, double>? monthlySales = await analysesReader
                  .getDailyTotalRevenueForMonth(now.month, now.year);
              print(monthlySales);
            },
            child: const Text("Aylık kazanç salla her gün"),
          ),
          TextButton(
            onPressed: () async {
              DateTime now = DateTime.now();

              Future<Map<String, dynamic>?> analysesFuture =
                  analysesReader.getDaySet(now.day, now.month, now.year);

              analysesFuture.then((analyses) {
                if (analyses != null) {
                  print("Bugünkü analizler: $analyses");
                  Future<double> totalRevenueFuture = analysesReader
                      .getDaysTotalRevenue(now.day, now.month, now.year);
                  /**/
                  totalRevenueFuture.then((totalRevenue) {
                    print("Bugünün toplam geliri: $totalRevenue");
                  });
                } else {
                  print("Bugünkü analizler bulunamadı.");
                }
              });
            },
            child: const Text("ay için günlük"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () async {
                    // Fonksiyon sonucunu beklemek için await kullanılır
                    Map<String, double> result = await analysesReader
                        .getMonthlyTotalRevenueForYear(DateTime.now().year);
                    print(result);
                  },
                  child: const Text("Yıl için aylık")),
              TextButton(
                  onPressed: () async {
                    // Fonksiyon sonucunu beklemek için await kullanılır
                    Map<String, double> result = await analysesReader
                        .getYearlyTotalRevenueForYear(DateTime.now().year);
                    print(result);
                  },
                  child: const Text("Yıl için yıllık")),
            ],
          ),
          TextButton(
              onPressed: () async {
                DateTime now = DateTime.now();

                Future<Map<String, dynamic>?> analysesFuture =
                    analysesReader.getMonthSet(now.month, now.year);

                analysesFuture.then((analyses) {
                  if (analyses != null) {
                    print("Bugünkü analizler: $analyses");
                  } else {
                    print("Bugünkü analizler bulunamadı.");
                  }
                });
              },
              //todo bu şekilde itemlist çıkarabiliriz bunu text analyses kısmına ekle
              child: const Text("itemlist çıkartmaya çalışıyoruz")),
          Container(
            color: Colors.red,
            child: const SizedBox(
              width: 20,
              height: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  Object analysesRaw =
                      (await analysesReader.getRawData(0)) as Object;
                  print(analysesRaw);
                },
                child: const Text("print analyses raw 0"),
              ),
              TextButton(
                onPressed: () async {
                  Object analysesRaw =
                      (await analysesReader.getRawData(1)) as Object;
                  print(analysesRaw);
                },
                child: const Text("print analyses raw 1"),
              ),
              TextButton(
                onPressed: () async {
                  Object analysesRaw =
                      (await analysesReader.getRawData(2)) as Object;
                  print(analysesRaw);
                },
                child: const Text("print analyses raw 2"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  resetAllAnalysesJsonData.resetAllTableJsonFiles(0);
                },
                child: const Text("Reset all the analyses data 0 "),
              ),
              TextButton(
                onPressed: () async {
                  resetAllAnalysesJsonData.resetAllTableJsonFiles(1);
                },
                child: const Text("Reset all the analyses data 1 "),
              ),
              TextButton(
                onPressed: () async {
                  resetAllAnalysesJsonData.resetAllTableJsonFiles(2);
                },
                child: const Text("Reset all the analyses data 2 "),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  resetAllAnalysesJsonData.loadExampleJsonData(0);
                },
                child: const Text("LoadExampleJsonData 0 "),
              ),
              TextButton(
                onPressed: () async {
                  resetAllAnalysesJsonData.loadExampleJsonData(1);
                },
                child: const Text("LoadExampleJsonData 1 "),
              ),
              TextButton(
                onPressed: () async {
                  resetAllAnalysesJsonData.loadExampleJsonData(2);
                },
                child: const Text("LoadExampleJsonData 2 "),
              ),
            ],
          ),
          Container(
            color: Colors.red,
            child: const SizedBox(
              width: 20,
              height: 20,
            ),
          ),
          TextButton(
            onPressed: () async {
              Object menu = (await readNewData.readJsonData()) as Object;
              print(menu);
              /* # # # # # # # #*/
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
              /*NEDEN OLMASIN */
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
