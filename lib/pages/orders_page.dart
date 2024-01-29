import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/menu_screen_widgets/order.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';
import '../constants/colors.dart';

/*  sadece azalt butonlarının olduğu o sayfa*/

class OrdersPage extends StatefulWidget {
  OrdersPage({super.key, required this.tableNum, required this.customFunction});

  late Map<String, dynamic>? initialOrders;
  final int tableNum;
  final Function customFunction;

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
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 3.0,
                ),
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return orders[index];
                },
              ),
            ),
          ),
          Expanded(
            /*alttaki ödeme ekranı*/
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: FutureBuilder(
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              children: [
                                ...buildOrderWidgets(bottomStrings),
                              ],
                            ),
                          ],
                        );
                      },
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
                          WriteTableData writeTableData = WriteTableData();

                          Map<String, int> separetedItems =
                              buildOrderTexts(bottomStrings);
                          for (var entry in separetedItems.entries) {
                            print(
                                "Şu an ${entry.key} ile muhattabız.  ${entry.value} tane var");
                            writeTableData.decreaseOneItem(
                                widget.tableNum, entry.key, entry.value);
                          }

                          bottomWidgets.clear();
                          widget.customFunction();
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
        final double price = (orderData["price"] / quantity);

        if (quantity != null && name != null) {
          setState(() {
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
          });
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

  Map<String, int> buildOrderTexts(List<String> orders) {
    Map<String, int> itemCounts = {};

    // Siparişleri say
    for (String order in orders) {
      if (itemCounts.containsKey(order)) {
        itemCounts[order] = (itemCounts[order] ?? 0) + 1;
      } else {
        itemCounts[order] = 1;
      }
    }

    // Itemleri sayılarına göre ayır
    Map<String, int> textMap = {};
    itemCounts.forEach((item, count) {
      textMap[item] = count;
    });

    return textMap;
  }

  int getItemCount(List<String> textList, String itemName) {
    int count = 0;

    for (String item in textList) {
      if (item == itemName) {
        count++;
      }
    }

    return count;
  }
}
