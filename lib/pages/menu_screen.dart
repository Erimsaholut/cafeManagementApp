import 'package:flutter/material.dart';
import '../constants/styles.dart';
import '../datas/menu_data/read_data.dart';
import '../utils/custom_button_with_checkboxes.dart';

/*itemlerin seçilip eklendiği o sayfa*/

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

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
      makeWidgetsForInd(readNewData.drinksWithIngredients, drinksIn);

      makeWidgetsForNoInd(readNewData.foodsWithNoIngredients, foodsNoIn);
      makeWidgetsForInd(readNewData.foodsWithIngredients, foodsIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Menü",
            style: CustomStyles.blackAndBoldTextStyleXl,
          ),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _buildOrderWidgets(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(8),
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
    // Map'i null olmayan bir şekilde başlat
    Map<String, int> itemCounts = {};

    for (String order in orders) {
      if (itemCounts.containsKey(order)) {
        // Null check ekleyin ve null değilse artırın
        itemCounts[order] = (itemCounts[order] ?? 0) + 1;
      } else {
        // Eğer order henüz eklenmemişse, 1 ile başlat
        itemCounts[order] = 1;
      }
    }

    // Widget listesini oluştur
    List<Widget> orderWidgets = [];
    itemCounts.forEach((item, count) {
      orderWidgets.add(Text('$count $item    '));
    });

    return orderWidgets;
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

  void makeWidgetsForNoInd(List<String> items, List<Widget> widgets) async {
    for (var itemName in items) {
      widgets.add(
        TextButton(
          style: CustomStyles.customMenuItemButtonStyle,
          onPressed: () {
            // Asenkron işlemleri burada gerçekleştirin
            _performAsyncOperations(itemName);
          },
          child: Text(itemName),
        ),
      );
    }
  }

  Future<void> _performAsyncOperations(String itemName) async {
    double itemPrice = await readNewData.getItemPrice(itemName);
    print('Price of $itemName: $itemPrice');
    setState(() {
      print(itemName);
      orders.add(itemName);
      totalPrice += itemPrice;
    });
  }

  void makeWidgetsForInd(List<Map<String, dynamic>> items,
      List<Widget> widgets) {
    for (var item in items) {
      List<String> ingredients = List<String>.from(item["ingredients"]);
      String name = item["name"];
      widgets.add(
        MyCustomButton(
          buttonText: name,
          checkboxTexts: ingredients,
          onPressed: () {
            _performAsyncOperationsForInd(name);
          },
        ),
      );
    }
  }

  Future<void> _performAsyncOperationsForInd(String name) async {
    print("Button pressed for $name");
    double itemPrice = await readNewData.getItemPrice(name);
    print('Price of $name: $itemPrice');

    setState(() {
      orders.add(name);
      totalPrice += itemPrice;
    });
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

//todo only one checkboxlu customWidget
//todo analiz sayfası ve dışarı aktarabilme özelliği
//todo tasarım
//todo firebase (dlc olarak sunucam onu)
//todo sipariş ödeme ekranı hallet
//todo bi tane genel emin misiniz widgetı oluştur resetleme ve ürün eklemeye koy her yere koy
