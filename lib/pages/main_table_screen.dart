import '../constants/custom_colors.dart';
import '../constants/styles.dart';
import '../datas/analyses_data/write_data_analyses.dart';
import '../datas/table_orders_data/read_table_data.dart';
import '../datas/table_orders_data/write_table_data.dart';
import '../utils/custom_alert_button.dart';
import '../utils/custom_menu_button.dart';
import 'package:flutter/material.dart';
import '../utils/is_table_name_null.dart';
import 'clases/order_indicator_class.dart';
import 'clases/table_order_class.dart';
import 'decrease_order.dart';
import 'increase_items.dart';

class MainTableScreen extends StatefulWidget {
  /*   ana,masa menüsü   */

  final int tableNum;
  final String tableName;

  const MainTableScreen(
      {super.key, required this.tableNum, required this.tableName});

  @override
  State<MainTableScreen> createState() => _MainTableScreenState();
}

class _MainTableScreenState extends State<MainTableScreen> {
  WriteAnalysesData writeAnalysesData = WriteAnalysesData();
  WriteTableData writeTableData = WriteTableData();
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
        backgroundColor: CustomColors.appbarColor,
      ),
      body: Container(
        color: CustomColors.backGroundColor,
        child: Row(
          children: [
            /*sol taraf*/
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    /*masadaki itemler*/
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        color: CustomColors.selectedColor1,
                        child: ListView.builder(
                          itemCount: orderWidgets.length,
                          itemBuilder: (context, index) {
                            return orderWidgets[index];
                          },
                        ),
                      ),
                    ),
                    /* masadaki itemlerin fiyatı */
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        color: CustomColors.selectedColor2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Toplam Fiyat: ${getTotalPrice(orderClass)} TL',
                              style: CustomTextStyles.blackAndBoldTextStyleL,
                            ),
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
              child: Column(
                /*masadaki itemler*/
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customMenuButton(
                    "Ekle Sipariş",
                    onPressedFunction: () {
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
                    },
                    context: context,
                  ),
                  customMenuButton(
                    "Azalt Sipariş",
                    onPressedFunction: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => DecreaseOrder(
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
                    },
                    context: context,
                  ),
                  customMenuButton(
                    "Masa Ödendi",
                    onPressedFunction: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertButton(
                            text1: ' Bütün masaya ödenecektir.',
                            text2: 'Emin misiniz ?',
                            customFunction: () {
                              setState(() {
                                Map<String, int> separetedItems = {};

                                for (TableOrderClass i in orderClass) {
                                  separetedItems[i.name] = i.quantity;
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
                    },
                    context: context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: CustomColors.backGroundColor,
    );
  }

  Future<void> addItemToAnalyses(Map<String, int> separatedItems) async {
    for (var item in separatedItems.entries) {
      await writeAnalysesData.addItemToAnalysesJson(item.key, item.value);
    }
  }

  void initialFunction() async {
    await setOrderClasses(widget.tableNum);

    setItemWidgets(orderClass);
  }

  /*okuduğu datadaki itemleri class olarak listeliyor*/

  Future<void> setOrderClasses(int tableNum) async {
    TableReader tableDataHandler = TableReader();

    Map<String, dynamic>? tableData =
        await tableDataHandler.getTableSet(tableNum);
    orderClass.clear();

    for (var i in tableData?["orders"]) {
      orderClass.add(
        TableOrderClass(
          name: i["name"],
          price: i["price"],
          quantity: i["quantity"],
        ),
      );
    }
  }

  void setItemWidgets(List<TableOrderClass> classList) {
    orderWidgets.clear();
    setState(() {
      for (TableOrderClass i in classList) {
        orderWidgets.add(OrderIndicatorButton(
          quantity: i.quantity,
          itemName: i.name,
          price: i.price,
          tableNum: widget.tableNum,
          initialFunction: () {
              initialFunction();
          },
        ));
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



