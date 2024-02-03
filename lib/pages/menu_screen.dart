import 'package:cafe_management_system_for_camalti_kahvesi/datas/table_orders_data/write_table_data.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/utils/custom_single_selection_checkbox_button.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';
import '../datas/menu_data/read_data.dart';
import '../utils/custom_multi_selection_checkbox_button.dart';

/*itemlerin seçilip eklendiği o sayfa*/

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key,required this.tableNum,required this.customFunction});

  final int tableNum;
  final Function customFunction;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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
          leading: IconButton(onPressed: () {Navigator.pop(context); widget.customFunction();  }, icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text(
            "Menü",
            style: CustomStyles.blackAndBoldTextStyleXl,
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                color: Colors.blueGrey,
                child: ListView(
                  children: [
                    buildItemTypeTextContainer("İçecekler"),
                    customSizedBox(),
                    buildGridView(drinksNoIn),
                    customSizedBox(rate: 2),
                    ...drinksIn,
                    customSizedBox(),
                    buildItemTypeTextContainer("Yiyecekler"),
                    customSizedBox(),
                    buildGridView(foodsNoIn),
                    customSizedBox(rate: 2),
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
                  color: Theme.of(context).colorScheme.inversePrimary,
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
                          color: Colors.greenAccent,
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
          style: CustomStyles.customMenuItemButtonStyle,
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
    print('Price of $itemName: $itemPrice');
    setState(() {
      print(itemName);
      orders.add(itemName);
      totalPrice += itemPrice;
      writeTableData.addItemToTable(widget.tableNum, itemName, 1, itemPrice);
    });
  }


  Future<void> _performAsyncOperationsForInd(String name,tableNum) async {
    print("Button pressed for $name");
    double itemPrice = await readNewData.getItemPrice(name);
    print('Price of $name: $itemPrice');

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
        style: CustomStyles.blackAndBoldTextStyleXl,
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

SizedBox customSizedBox({int rate = 1}) {
  return SizedBox(height: 16 * rate.toDouble());
}

//todo analiz sayfası ve dışarı aktarabilme özelliği
//todo tasarım
//todo firebase (dlc olarak sunucam onu)
//todo sipariş ödeme ekranı hallet
//todo bi tane genel emin misiniz widgetı oluştur resetleme ve ürün eklemeye koy her yere koy
//todo masa sayısı denetleyen bir kod yaz denetleme (maks mas sayısı döndürme falan) data klasöründeki datalrda olsun.
//todo dil desteği gelecek ama nasıl gelecek bilmiyorum
//todo masa resetlemek için döngü kullanılarak anlık bir dosya hazırlanıcak limitleme kendini
//todo masa seçimi için yeni number pickerlardan kullan
//todo yeni item eklerken isim kontrolü yapılsın