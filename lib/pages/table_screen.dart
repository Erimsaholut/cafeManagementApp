import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/menu_screen.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/is_table_name_null.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import '../utils/custom_menu_button.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'orders_page.dart';

class CustomTableMenu extends StatelessWidget {
  /* genel bakışların olduğu sayfa*/

  final int tableNum;
  final String tableName;
  final List<Widget> orders = [];
  late Future<int> totalPrice;


  CustomTableMenu(
      {super.key, required this.tableNum, required this.tableName}) {
    totalPrice = getTotalPrice(tableNum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isTableNameNull(tableName, tableNum),
        backgroundColor: CustomColors.appbarBlue,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.lime,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.deepPurple.shade200,
                      child: FutureBuilder<void>(
                        future: setTableData(tableNum, orders),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView.builder(
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                return orders[index];
                              },
                            );
                          } else {
                            return const CircularProgressIndicator(); // ya da başka bir yükleme göstergesi
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.redAccent,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8.0,
                          ),
                          FutureBuilder<int>(
                            future: totalPrice,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(
                                  "Toplam Hesap: ${snapshot.data} ₺",
                                  style: CustomStyles.blackAndBoldTextStyleL,
                                );
                              } else {
                                return const CircularProgressIndicator(); // You can replace this with a loading indicator
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.tealAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomMenuButton("Ekle Sipariş", onPressedFunction: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const MenuScreen(),
                        transitionsBuilder: (_, anim, __, child) {
                          return ScaleTransition(
                            scale: anim,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  }),
                  CustomMenuButton(
                    "Azalt Sipariş",
                    onPressedFunction: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => OrdersPage(
                            initialOrders: orders,
                          ),
                          transitionsBuilder: (_, anim, __, child) {
                            return ScaleTransition(
                              scale: anim,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                  ),
                  CustomMenuButton("Masa Ödendi", onPressedFunction: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFAEE2FF),
    );
  }
}

List<Widget> textWidgetsFromList(List<String> textList) {
  List<Widget> newList = [];
  for (var i in textList) {
    newList.add(
      Text(
        i,
        style: CustomStyles.blackAndBoldTextStyleM,
      ),
    );
  }

  return newList;
}

Future<void> setTableData(int tableNum, List<Widget> orders) async {
  TableDataHandler tableDataHandler = TableDataHandler();
  Map<String, dynamic>? tableData =
      await tableDataHandler.getTableSet(tableNum);
  for (var i in tableData?["orders"]) {
    orders.add(orderShown(i["quantity"], i["name"], i["price"]));
  }
}

Future<int> getTotalPrice(int tableNum) async {
  TableDataHandler tableDataHandler = TableDataHandler();
  int tableTotalPrice = await tableDataHandler.getTableTotalPrice(tableNum);
  return tableTotalPrice;
}

Widget orderShown(int quantity, String itemName, int price) {
  return Column(
    children: [
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex:1,
              child: Text(
                "$quantity",
                style: CustomStyles.blackAndBoldTextStyleM,
              ),
            ),
            Expanded(
              flex:5,
              child: Text(
                itemName,
                style: CustomStyles.blackAndBoldTextStyleM,
              ),
            ),
            Expanded(
              flex:2,
              child: Text(
                "$price TL",
                style: CustomStyles.blackAndBoldTextStyleM,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
    ],
  );
}
