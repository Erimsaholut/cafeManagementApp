import '../settings_page_widgets/item_type_selector.dart';
import '../settings_page_widgets/custom_text_field.dart';
import '../../../datas/menu_data/write_data_menu.dart';
import '../settings_page_widgets/ingredients.dart';
import '../../../constants/custom_colors.dart';
import '../../../utils/custom_divider.dart';
import '../../../utils/price_picker.dart';
import '../../../constants/styles.dart';
import 'package:flutter/material.dart';

class AddNewItemToMenu extends StatefulWidget {
  const AddNewItemToMenu({super.key});

  @override
  AddNewItemToMenuState createState() => AddNewItemToMenuState();
}

class AddNewItemToMenuState extends State<AddNewItemToMenu> {
  final TextEditingController beverageNameController = TextEditingController();
  WriteData writeData = WriteData();
  CustomItemTypeSelector customItemTypeSelector = CustomItemTypeSelector(
    question: 'Ürün tipini seçin',
    option1: 'İçecek',
    option2: 'Yiyecek',
    itemType: "İçecek",
  );

  List<String> indList = [];
  int moneyValue = 15;
  int pennyValue = 0;
  double profit = 0;
  late String beverageName;
  String itemType = "Yiyecek";
  bool isValueEnteredForProfit = true;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Menu Item"),
        backgroundColor: CustomColors.appbarColor,
      ),
      body: Container(
        color: CustomColors.backGroundColor,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                buildCustomTextField(
                    "Ürün İsmi", beverageNameController, context),
                CustomDivider(),
                customItemTypeSelector,
                CustomDivider(),
                PricePicker(
                  name: "Ürün Fiyatı Belirle",
                  onValueChanged: (int money, int penny) {
                    setState(() {
                      moneyValue = money;
                      pennyValue = penny;
                    });
                  },
                ),
                CustomDivider(),
                Column(
                  children: [
                    Text(
                      "Ürün adetindeki kâr miktarı",
                      style: CustomTextStyles.blackAndBoldTextStyleXl,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isValueEnteredForProfit = true;
                              });
                            },
                            child: const Text("Değer gir")),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isValueEnteredForProfit = false;
                              });
                            },
                            child: const Text("Yüzde gir")),
                      ],
                    ),
                    SizedBox(
                      width: (screenSize.width / 3),
                      child: Row(
                        children: [
                          (isValueEnteredForProfit)
                              ? const Text("Değer:    ")
                              : const Text("Yüzde: %"),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: (isValueEnteredForProfit)
                                    ? "Değer Giriniz"
                                    : "Yüzde giriniz",
                                errorText: (profit > moneyValue)
                                    //profit değil value ya da profit < moneyvalue
                                    ? "Kâr satış fiyatından fazla olamaz"
                                    : (profit < 0)
                                        ? "Kâr sıfırdan küçük olamaz"
                                        : null,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (isValueEnteredForProfit) {
                                    profit = double.tryParse(value) ?? 0.0;
                                  } else {
                                    profit = ((moneyValue * 100 + pennyValue) /
                                            10000) *
                                        (double.tryParse(value) ?? 0.0 / 100);
                                    profit =
                                        double.parse(profit.toStringAsFixed(2));
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text("1 adet üründen elde edilen kâr: $profit ₺"),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                CustomDivider(),
                Ingredients(indList: indList),
                CustomDivider(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    beverageName = beverageNameController.text;

                    String selectedItemType = customItemTypeSelector.itemType;

                    if (beverageName.isEmpty) {
                      scaffoldMessage("Ürün ismi boş olamaz", context);
                    } else {
                      bool? result = await writeData.addNewItemToMenu(
                          beverageName,
                          moneyValue,
                          pennyValue,
                          indList,
                          selectedItemType,
                          profit: profit);

                      if (result != null) {
                        if (result) {
                          scaffoldMessage(
                              "Yeni ürün başarı ile kaydedildi..", context);
                        } else {
                          scaffoldMessage(
                              "Yeni ürün eklenirken bir hata ile karşılaşıldı",
                              context);
                        }
                      } else {
                        // Handle null case here
                        print(
                            "Beklenmeyen bir hata oluştu. addNewItemToMenu null değer döndürdü.");
                      }
                    }
                  },
                  child: const Text("Kaydet"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> scaffoldMessage(
    String message, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
