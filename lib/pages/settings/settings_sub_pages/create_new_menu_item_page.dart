import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/material.dart';
import '../../../constants/custom_colors.dart';
import '../../../datas/menu_data/write_data_menu.dart';
import '../../../utils/custom_divider.dart';
import '../settings_page_widgets/custom_text_field.dart';
import '../settings_page_widgets/ingredients.dart';
import '../settings_page_widgets/item_type_selector.dart';
import '../../../utils/price_picker.dart';

class AddNewItemToMenu extends StatefulWidget {
  const AddNewItemToMenu({Key? key}) : super(key: key);

  @override
  _AddNewItemToMenuState createState() => _AddNewItemToMenuState();
}

class _AddNewItemToMenuState extends State<AddNewItemToMenu> {
  final TextEditingController beverageNameController = TextEditingController();
  WriteData writeData = WriteData();
  CustomItemTypeSelector customItemTypeSelector = CustomItemTypeSelector(
    question: 'Ürün tipini seçin',
    option1: 'Yiyecek',
    option2: 'İçecek',
    itemType: "Yiyecek",
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
                      width: (screenSize.width / 4),
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
                                errorText: (isValueEnteredForProfit)
                                    ? null
                                    : (double.tryParse(value) < 0 || double.tryParse(value) > 100)
                                        ? "Değer 0 ile 100 arasında olmalıdır."
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
                                    //todo bunu bitir sonra profit alacak şekilde data düzenle
                                    //todo ürün düzenleme kısmına da ekle
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text("1 adet üründen elde edilen kâr: $profit ₺"),
                    SizedBox(
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
                    print("$beverageName, $moneyValue, $pennyValue");
                    print(indList);

                    String selectedItemType = customItemTypeSelector.itemType;
                    print("Selected Item Type: $selectedItemType");

                    if (beverageName.isEmpty) {
                      scaffoldMessage("Ürün ismi boş olamaz", context);
                    } else {
                      bool? result = await writeData.addNewItemToMenu(
                          beverageName,
                          moneyValue,
                          pennyValue,
                          indList,
                          selectedItemType);

                      if (result != null) {
                        if (result) {
                          scaffoldMessage(
                              "Yeni ürün başarı ile kaydedildi. $beverageName, $moneyValue, $pennyValue $indList, $selectedItemType",
                              context);
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
