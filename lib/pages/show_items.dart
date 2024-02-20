import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/increase_items.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/is_table_name_null.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import '../utils/custom_alert_button.dart';
import '../utils/custom_menu_button.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'decrease_order.dart';

class CustomTableMenu extends StatefulWidget {
  /* genel bakışların olduğu sayfa*/

  final int tableNum;
  final String tableName;
  late Future<double> totalPrice;

  CustomTableMenu(
      {super.key, required this.tableNum, required this.tableName}) {
    totalPrice = getTotalPrice(tableNum);
  }

  @override
  State<CustomTableMenu> createState() => _CustomTableMenuState();
}

class _CustomTableMenuState extends State<CustomTableMenu> {
  final List<Widget> orders = [];
  Map<String, dynamic>? test;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isTableNameNull(widget.tableName, widget.tableNum),
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
                        future: setTableData(widget.tableNum, orders, test),
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
                            return const CircularProgressIndicator();
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
                          FutureBuilder<double>(
                            future: widget.totalPrice,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(
                                  "Toplam Hesap: ${snapshot.data} ₺",
                                  style: CustomStyles.blackAndBoldTextStyleL,
                                );
                              } else {
                                return const CircularProgressIndicator();
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
                        pageBuilder: (_, __, ___) => IncreaseOrder(
                          tableNum: widget.tableNum,
                          customFunction: () {
                            manualSetState();
                          },
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
                  }),
                  CustomMenuButton(
                    "Azalt Sipariş",
                    onPressedFunction: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => Decrease0rder(
                            tableNum: widget.tableNum,
                            customFunction: () {
                              manualSetState();
                            },
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
                  CustomMenuButton("Masa Ödendi", onPressedFunction: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertButton(
                          text1: ' Bütün masayı ödenecektir.',
                          text2: 'Emin misiniz ?',
                          customFunction: () {
                            WriteTableData writeTableData = WriteTableData();
                            writeTableData.resetOneTable(widget.tableNum);
                            orders.clear();
                            Navigator.pop(context);
                            widget.totalPrice = getTotalPrice(widget.tableNum);
                            setState(() {});
                          },
                        );
                      },
                    );
                    //Todo (buraya indirimli parametre gelecek)
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFAEE2FF),
    );
  }

  void manualSetState() {
    setState(() {
      orders.clear();
      widget.totalPrice = getTotalPrice(widget.tableNum);
    });
  }

  Future<void> setTableData(
      int tableNum, List<Widget> orders, Map<String, dynamic>? test) async {
    TableDataHandler tableDataHandler = TableDataHandler();
    Map<String, dynamic>? tableData =
        await tableDataHandler.getTableSet(tableNum);
    test = tableData;

    print(tableData);

    for (var i in tableData?["orders"]) {
      orders.add(orderShown(i["quantity"], i["name"], i["price"]));
    }
  }
}

Future<double> getTotalPrice(int tableNum) async {
  TableDataHandler tableDataHandler = TableDataHandler();
  double tableTotalPrice = await tableDataHandler.getTableTotalPrice(tableNum);
  return tableTotalPrice;
}

Widget orderShown(int quantity, String itemName, double price) {
  return Column(
    children: [
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "$quantity",
                style: CustomStyles.blackAndBoldTextStyleM,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                itemName,
                style: CustomStyles.blackAndBoldTextStyleM,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "$price ₺",
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
