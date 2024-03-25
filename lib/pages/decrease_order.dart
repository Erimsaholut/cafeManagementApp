import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/write_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/menu_screen_widgets/order.dart';
import 'package:flutter/material.dart';
import '../constants/interface_colors.dart';

class Decrease0rder extends StatefulWidget {
  const Decrease0rder(
      {super.key, required this.tableNum, required this.initialFunction});

  final int tableNum;
  final Function initialFunction;

  @override
  _Decrease0rderState createState() => _Decrease0rderState();
}

class _Decrease0rderState extends State<Decrease0rder> {
  WriteAnalysesData writeAnalysesData = WriteAnalysesData();
  TableReader tableDataHandler = TableReader();
  List<String> bottomStrings = [];
  List<Widget> orders = [];
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _loadTableData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              widget.initialFunction();
              print("çıkıldı");
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text("Sipariş Öde"),
        backgroundColor: CustomColors.appbarBlue,
      ),
      body: Column(
        children: [
          /*yeşil buton ekranı*/
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
          /*mavi özet ve fiyat ekranı*/
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
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
                    flex: 1,
                    child: Text("$totalAmount ₺"),
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        Map<String, int> separetedItems = buildOrderTexts(bottomStrings);

                        // Diğer işlemleri yap
                        WriteTableData writeTableData = WriteTableData();
                        await writeTableData.decreaseItemList(widget.tableNum, separetedItems);

                        // Diğer işlemler tamamlandıktan sonra analizleri JSON'a ekle
                        await addItemToAnalyses(separetedItems);

                        // Diğer işlemler tamamlandıktan sonra işlemleri temizle
                        setState(() {
                          bottomStrings.clear();
                          totalAmount = 0;
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


  Future<void> addItemToAnalyses(Map<String, int> separetedItems) async {
    for (var item in separetedItems.entries) {
      await writeAnalysesData.addItemToAnalysesJson(item.key, item.value);
    }
  }
  /*local filestan verileri çekiyor*/
  /*setTabelData çalıştırıyor dataları verip*/
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

  /*rawdatadaki itemları kendi Order widgetında yaratıyor*/
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
              toplamHesap: totalAmount,
              manualSetState: () {
                manualSetState();
              },
              price: price,
              arttirToplamHesap: (double price) {
                totalAmount += price;
              },
              azaltToplamHesap: (double price) {
                totalAmount -= price;
              },
            ));
          });
        }
      }
    }
  }

  /*aldığı orderlerı */
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

  /*alttaki yazıları string olarak gruplayarak yazıyor*/
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
}
