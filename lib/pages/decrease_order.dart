import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/menu_screen_widgets/order.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';
import '../constants/colors.dart';

class Decrease0rder extends StatefulWidget {
  Decrease0rder({super.key, required this.tableNum, required this.customFunction});

  final int tableNum;
  final Function customFunction;

  @override
  _Decrease0rderState createState() => _Decrease0rderState();
}

class _Decrease0rderState extends State<Decrease0rder> {
  TableDataHandler tableDataHandler = TableDataHandler();
  List<Widget> orders = [];
  List<String> bottomStrings = [];
  double toplamHesap = 0.0;

  @override
  void initState() {
    super.initState();
    _loadTableData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sipariş Öde"),
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
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FutureBuilder<Text>(
                      future: buildBottomPriceText(toplamHesap),
                      builder: (BuildContext context, AsyncSnapshot<Text> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return snapshot.data!;
                            }
                          default:
                            return Text('Unexpected ConnectionState: ${snapshot.connectionState}');
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          WriteTableData writeTableData = WriteTableData();

                          Map<String, int> separetedItems = buildOrderTexts(bottomStrings);
                          for (var entry in separetedItems.entries) {
                            print("Şu an ${entry.key} ile muhattabız.  ${entry.value} tane var");
                            writeTableData.decreaseOneItem(widget.tableNum, entry.key, entry.value);
                          }

                          bottomStrings.clear();
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
      Map<String, dynamic>? data = await tableDataHandler.getTableSet(widget.tableNum);
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


              arttirToplamHesap: (double price) {
                toplamHesap += price;
              },
              azaltToplamHesap: (double price) {
                toplamHesap -= price;
              },


            ));
          });
        }
      }
    }
  }

  List<Widget> buildOrderWidgets(List<String> orders) {
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

    for (String order in orders) {
      if (itemCounts.containsKey(order)) {
        itemCounts[order] = (itemCounts[order] ?? 0) + 1;
      } else {
        itemCounts[order] = 1;
      }
    }

    Map<String, int> textMap = {};
    itemCounts.forEach((item, count) {
      textMap[item] = count;
    });

    return textMap;
  }

  Future<Text> buildBottomPriceText(double bottomPriceText) async {
    print('Price: $bottomPriceText');

    return Text('Price: $bottomPriceText');
  }
}
