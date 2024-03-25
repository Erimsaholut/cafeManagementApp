import 'package:cafe_management_system_for_camalti_kahvesi/datas/analyses_data/write_data_analyses.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/read_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/clases/table_order_class.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/is_table_name_null.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/pages/increase_items.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import '../utils/custom_alert_button.dart';
import '../utils/custom_menu_button.dart';
import 'package:flutter/material.dart';
import '../constants/interface_colors.dart';
import 'decrease_order.dart';

class MainTableScreen extends StatefulWidget {
  /*   ana,masa menüsü   */

  final int tableNum;
  final String tableName;

  MainTableScreen({super.key, required this.tableNum, required this.tableName});

  @override
  State<MainTableScreen> createState() => _MainTableScreenState();
}

class _MainTableScreenState extends State<MainTableScreen> {
  List<TableOrderClass> orderClass = [];
  final List<Widget> orderWidgets = [];

  @override
  void initState() {
    super.initState();
    initialFunction();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: isTableNameNull(widget.tableName, widget.tableNum),
        backgroundColor: CustomColors.appbarBlue,
      ),
      body: Row(
        children: [
          /*sol taraf*/
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.lime,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  /*masadaki itemler*/
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.deepPurple.shade200,
                      child: ListView.builder(
                        itemCount: orderWidgets.length,
                        itemBuilder: (context, index) {
                          return orderWidgets[index];
                        },
                      ),
                    ),
                  ),
                  /*masadaki itemlerin fiyatı*/
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Toplam Fiyat: ${getTotalPrice(orderClass)} TL',style: CustomStyles.blackAndBoldTextStyleL,),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*sağ taraf*/
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.tealAccent,
              /*Butonlar*/
              child: Column(
                /*masadaki itemler*/
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomMenuButton("Ekle Sipariş", onPressedFunction: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => IncreaseOrder(
                          tableNum: widget.tableNum,
                          initialFunction: () {
                            initialFunction();
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
                  }, context: context,),
                  CustomMenuButton(
                    "Azalt Sipariş",
                    onPressedFunction: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => Decrease0rder(
                            tableNum: widget.tableNum,
                            initialFunction: () {
                              initialFunction();
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
                    }, context: context,
                  ),
                  CustomMenuButton(
                    "Masa Ödendi",
                    onPressedFunction: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertButton(
                            text1: ' Bütün masayı ödenecektir.',
                            text2: 'Emin misiniz ?',
                            customFunction: () {
                              setState(() {
                                WriteTableData writeTableData =
                                    WriteTableData();

                                Map<String, int> separetedItems = {};

                                for (TableOrderClass i in orderClass) {
                                  separetedItems[i.name] = i.quantity;
                                }

                                Future<void> addItemToAnalyses(
                                    Map<String, int> separetedItems) async {
                                  WriteAnalysesData writeAnalysesData =
                                      WriteAnalysesData();
                                  for (var item in separetedItems.entries) {
                                    await writeAnalysesData
                                        .addItemToAnalysesJson(
                                            item.key, item.value);
                                  }
                                }

                                addItemToAnalyses(separetedItems);
                                writeTableData.resetOneTable(widget.tableNum);
                                orderWidgets.clear();
                                orderClass.clear();

                                Navigator.pop(context);
                              });
                            },
                          );
                        },
                      );
                    }, context: context,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFAEE2FF),
    );
  }

  void initialFunction() async {
    await setOrderClasses(widget.tableNum);

    setItemWidgets(orderClass);
  }

  void manualSetState() {
    setState(() {});
  }

/*okuduğu datadaki itemleri class olarak listeliyor*/
  /*allahın emri olarak bir kere çalışacak*/

  Future<void> setOrderClasses(int tableNum) async {
    TableReader tableDataHandler = TableReader();

    Map<String, dynamic>? tableData =
        await tableDataHandler.getTableSet(tableNum);

    orderClass.clear();

    for (var i in tableData?["orders"]) {
      orderClass.add(
        TableOrderClass(
            name: i["name"], price: i["price"], quantity: i["quantity"]),
      );
    }
  }

  void setItemWidgets(List<TableOrderClass> classList) {
    orderWidgets.clear();
    setState(() {
      for (TableOrderClass i in classList) {
        orderWidgets.add(orderShown(i.quantity, i.name, i.price));
      }
    });
  }
}

/* classlardan toplam fiyatı alıyor */
double getTotalPrice(List<TableOrderClass> classList) {
  double totalPrice = 0;

  for (TableOrderClass i in classList) {
    totalPrice += i.price;
  }

  return totalPrice;
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
