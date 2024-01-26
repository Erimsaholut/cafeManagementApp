import 'dart:ffi';

import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/menu_screen_widgets/order.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';
import '../constants/colors.dart';

/*  sadece azalt butonlarının olduğu o sayfa*/

class OrdersPage extends StatefulWidget {
  OrdersPage({super.key, required this.tableNum});

  late Map<String, dynamic>? initialOrders;
  final int tableNum;

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  TableDataHandler tableDataHandler = TableDataHandler();
  List<Widget> orders = [];

  List<String> bottomStrings = [];
  List<Widget> bottomWidgets = [];

  double toplamHesap = 0;

  @override
  void initState() {
    super.initState();
    _loadTableData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sipariş Öde"),
        backgroundColor: CustomColors.appbarBlue,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.lime,
              child: GridView.count(
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                crossAxisCount: 4,
                children: orders,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          children: [
                            ...buildOrderWidgets(bottomStrings),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Hesap: $toplamHesap ₺",
                      style: CustomStyles.blackAndBoldTextStyleM,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {

                        });
                      },
                      child: const Text("Onayla"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadTableData() async {
    try {
      Map<String, dynamic>? data =
          await tableDataHandler.getTableSet(widget.tableNum);
      setTableData(data);
    } catch (error) {
      print("Error loading table data: $error");
    }
  }

  void manualSetState() {
    setState(() {});
  }

  void setTableData(Map<String, dynamic>? tableData) {
    if (tableData != null && tableData.containsKey("orders")) {
      for (var orderData in tableData["orders"] as List<dynamic>) {
        final int? quantity = orderData["quantity"];
        final String? name = orderData["name"];
        final double price = orderData["price"];

        if (quantity != null && name != null) {
          orders.add(Order(
            maxCount: quantity,
            name: name,
            textList: bottomStrings,
            toplamHesap: toplamHesap,
            manualSetState: () {
              manualSetState();
            },
            price: price,
          ));
        }
      }
    }
  }

  List<Widget> buildOrderWidgets(orders) {
    Map<String, int> itemCounts = {};

    for (String order in orders) {
      if (itemCounts.containsKey(order)) {
        itemCounts[order] = (itemCounts[order] ?? 0) + 1;
      } else {
        itemCounts[order] = 1;
      }
    }
    List<Widget> orderWidgets = [];
    itemCounts.forEach((item, count) {
      orderWidgets.add(Text('$count $item    '));
    });

    return orderWidgets;
  }
}
