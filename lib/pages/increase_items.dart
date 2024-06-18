import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import '../utils/custom_single_selection_checkbox_button.dart';
import '../utils/custom_multi_selection_checkbox_button.dart';
import '../datas/table_orders_data/write_table_data.dart';
import '../datas/menu_data/read_data_menu.dart';
import '../constants/custom_colors.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';

class IncreaseOrder extends StatefulWidget {
  const IncreaseOrder(
      {super.key, required this.tableNum, required this.initialFunction});

  final int tableNum;
  final Function initialFunction;

  @override
  State<IncreaseOrder> createState() => _IncreaseOrderState();
}

class _IncreaseOrderState extends State<IncreaseOrder> {
  late Future<void> _future;
  final ReadMenuData _readMenuData = ReadMenuData();
  Map<String, List<Map<String, dynamic>>> _categorizedItems = {};
  List<String> orders = [];
  double totalPrice = 0;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _future = _initializeMenuData();
  }

  Future<void> _initializeMenuData() async {
    await _readMenuData.initialize();
    await _readMenuData.separateMenuItemsByCategory();
    setState(() {
      _categorizedItems = _readMenuData.getCategorizedItems();
      categories = _categorizedItems.keys.toList();
    });
  }

  List<Widget> createFabButtons() {
    return categories.map((category) {
      return FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        heroTag: category,
        tooltip: category,
        child: Text(category),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: categories.length >= 2
          ? AnimatedFloatingActionButton(
        fabButtons: createFabButtons(),
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.red,
        animatedIconData: AnimatedIcons.menu_close,
      )
          : null,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            widget.initialFunction();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Menü",
          style: CustomTextStyles.blackAndBoldTextStyleXl,
        ),
        backgroundColor: CustomColors.appbarColor,
      ),
      body: Container(
        color: CustomColors.backGroundColor,
        child: FutureBuilder<void>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      color: CustomColors.backGroundColor2,
                      child: ListView(
                        children: categories.expand((category) {
                          List<Map<String, dynamic>> items = _categorizedItems[category]!;
                          List<Widget> itemsNoIngredients = [];
                          List<Widget> itemsWithIngredients = [];

                          for (var item in items) {
                            if (item['ingredients'] != null && item['ingredients'].isNotEmpty) {
                              if (category == 'Yiyecekler') {
                                itemsWithIngredients.add(makeWidgetForIndFood(item));
                              } else {
                                itemsWithIngredients.add(makeWidgetForIndDrink(item));
                              }
                            } else {
                              itemsNoIngredients.add(makeWidgetForNoInd(item['name']));
                            }
                          }

                          return [
                            buildItemTypeTextContainer(category),
                            const SizedBox(height: 16),
                            buildGridView(itemsNoIngredients),
                            const SizedBox(height: 16),
                            ...itemsWithIngredients,
                            const SizedBox(height: 32),
                          ];
                        }).toList(),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (orders.isNotEmpty),
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        color: CustomColors.selectedColor1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: _buildOrderWidgets(),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: CustomColors.selectedColor2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Toplam Fiyat: $totalPrice'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> _buildOrderWidgets() {
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

  Widget makeWidgetForNoInd(String itemName) {
    return TextButton(
      style: CustomButtonStyles.customMenuItemButtonStyle,
      onPressed: () {
        _performAsyncOperations(itemName);
      },
      child: Text(itemName),
    );
  }

  Widget makeWidgetForIndFood(Map<String, dynamic> item) {
    List<String> ingredients = List<String>.from(item["ingredients"]);
    String name = item["name"];
    return CustomMultiSelectionButton(
      buttonText: name,
      checkboxTexts: ingredients,
      onPressed: () {
        _performAsyncOperationsForInd(name, widget.tableNum);
      },
    );
  }

  Widget makeWidgetForIndDrink(Map<String, dynamic> item) {
    List<String> ingredients = List<String>.from(item["ingredients"]);
    String name = item["name"];
    return CustomSingleSelectionButton(
      buttonText: name,
      checkboxTexts: ingredients,
      onPressed: () {
        _performAsyncOperationsForInd(name, widget.tableNum);
      },
    );
  }

  Future<void> _performAsyncOperations(String itemName) async {
    WriteTableData writeTableData = WriteTableData();
    double itemPrice = await _readMenuData.getItemPrice(itemName);
    setState(() {
      orders.add(itemName);
      totalPrice += itemPrice;
      writeTableData.addItemToTable(widget.tableNum, itemName, 1, itemPrice);
    });
  }

  Future<void> _performAsyncOperationsForInd(String name, tableNum) async {
    double itemPrice = await _readMenuData.getItemPrice(name);

    WriteTableData writeTableData = WriteTableData();

    setState(() {
      orders.add(name);
      totalPrice += itemPrice;
      writeTableData.addItemToTable(tableNum, name, 1, itemPrice);
    });
  }

  Container buildItemTypeTextContainer(String text) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: CustomTextStyles.blackAndBoldTextStyleXl,
      ),
    );
  }

  Widget buildGridView(List<Widget> list) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 32.0,
        mainAxisSpacing: 32.0,
      ),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return list[index];
      },
    );
  }
}




//todo alttaki bar gelecek
//todo ayarlara kategori ekleme silme gelecek
//kategorisiz itemleri düzenleme gelecek