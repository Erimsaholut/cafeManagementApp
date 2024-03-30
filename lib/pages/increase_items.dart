import 'package:cafe_management_system_for_camalti_kahvesi/utils/custom_single_selection_checkbox_button.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';
import '../utils/custom_multi_selection_checkbox_button.dart';
import '../datas/menu_data/read_data_menu.dart';
import '../constants/custom_colors.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';


/*itemlerin seçilip eklendiği o sayfa*/

class IncreaseOrder extends StatefulWidget {
  const IncreaseOrder({super.key,required this.tableNum,required this.initialFunction});

  final int tableNum;
  final Function initialFunction;

  @override
  State<IncreaseOrder> createState() => _IncreaseOrderState();
}

class _IncreaseOrderState extends State<IncreaseOrder> {
  final ReadData readNewData = ReadData();

  List<String> orders = [];

  double totalPrice = 0;

  List<Widget> drinksNoIn = [];

  List<Widget> drinksIn = [];

  List<Widget> foodsNoIn = [];

  List<Widget> foodsIn = [];


  @override
  void initState() {
    super.initState();
    createButtons();
  }

  void createButtons() {
    setState(() {
      makeWidgetsForNoInd(readNewData.drinksWithNoIngredients, drinksNoIn);
      makeWidgetsForIndDrink(readNewData.drinksWithIngredients, drinksIn);

      makeWidgetsForNoInd(readNewData.foodsWithNoIngredients, foodsNoIn);
      makeWidgetsForIndFood(readNewData.foodsWithIngredients, foodsIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {Navigator.pop(context); widget.initialFunction();  print("çıkıldı");  }, icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text(
            "Menü",
            style: CustomTextStyles.blackAndBoldTextStyleXl,
          ),
          backgroundColor: CustomColors.appbarColor,
        ),
        body: Container(
          color: CustomColors.backGroundColor,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  color: CustomColors.backGroundColor2,
                  child: ListView(
                    children: [
                      buildItemTypeTextContainer("İçecekler"),
                      const SizedBox(height: 16,),
                      buildGridView(drinksNoIn),
                      const SizedBox(height: 32,),
                      ...drinksIn,
                      const SizedBox(height: 16,),
                      buildItemTypeTextContainer("Yiyecekler"),
                      const SizedBox(height: 16,),
                      buildGridView(foodsNoIn),
                      const SizedBox(height: 32,),
                      ...foodsIn,
                    ],
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
          ),
        ));
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


  void makeWidgetsForNoInd(List<String> items, List<Widget> widgets) async {
    for (var itemName in items) {
      widgets.add(
        TextButton(
          style: CustomButtonStyles.customMenuItemButtonStyle,
          onPressed: () {
            _performAsyncOperations(itemName);
          },
          child: Text(itemName),
        ),
      );
    }
  }

  void makeWidgetsForIndFood(
      List<Map<String, dynamic>> items, List<Widget> widgets) {
    for (var item in items) {
      List<String> ingredients = List<String>.from(item["ingredients"]);
      String name = item["name"];
      widgets.add(
        CustomMultiSelectionButton(
          buttonText: name,
          checkboxTexts: ingredients,
          onPressed: () {
            _performAsyncOperationsForInd(name,widget.tableNum);
          },
        ),
      );
    }
  }


  void makeWidgetsForIndDrink(
      List<Map<String, dynamic>> items, List<Widget> widgets) {
    for (var item in items) {
      List<String> ingredients = List<String>.from(item["ingredients"]);
      String name = item["name"];
      widgets.add(
        CustomSingleSelectionButton(
          buttonText: name,
          checkboxTexts: ingredients,
          onPressed: () {
            _performAsyncOperationsForInd(name,widget.tableNum);
          },
        ),
      );
    }
  }


  Future<void> _performAsyncOperations(String itemName) async {
    WriteTableData writeTableData = WriteTableData();
    double itemPrice = await readNewData.getItemPrice(itemName);
    setState(() {
      print(itemName);
      orders.add(itemName);
      totalPrice += itemPrice;
      writeTableData.addItemToTable(widget.tableNum, itemName, 1, itemPrice);
    });
  }


  Future<void> _performAsyncOperationsForInd(String name,tableNum) async {
    double itemPrice = await readNewData.getItemPrice(name);

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

//todo bi tane genel emin misiniz widgetı oluştur resetleme ve ürün eklemeye koy her yere koy

//todo dil desteği gelecek ama nasıl gelecek bilmiyorum

//todo firebase (dlc olarak sunucam onu)

//todo analiz sayfası ve dışarı aktarabilme özelliği


//todo masalara renk değiştirme özelliği
//todo değişiklik anında read çağır seperate mesela

//todo analyseslara text halinde veriler gelecek

