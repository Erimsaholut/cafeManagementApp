import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/write_data_menu.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data_menu.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_colors.dart';
import '../../../utils/price_picker.dart';
import '../../../constants/styles.dart';
import 'package:flutter/material.dart';
import 'edit_items_page.dart';

class ItemStudio extends StatefulWidget {
  const ItemStudio({super.key, required this.item,required this.processMenu});

  final EditableItem item;
  final Function processMenu;

  @override
  State<ItemStudio> createState() => _ItemStudioState();
}

class _ItemStudioState extends State<ItemStudio> {
  List<EditableItem> items = [];
  late int initialMoneyValue;
  late int initialPennyValue;
  late int newMoneyValue;
  late int newPennyValue;
  late double initialProfit;
  bool isValueEnteredForProfit = true;
  late double profit;
  final TextEditingController itemNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialMoneyValue = widget.item.price.floor();
    initialPennyValue = ((widget.item.price - widget.item.price.floor()) * 100).round();
    initialProfit = widget.item.profit;
    newMoneyValue = initialMoneyValue;
    newPennyValue = initialPennyValue;
    profit = initialProfit;
    _processMenuData();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WriteData writeData = WriteData();
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        title: Text("Edit ${widget.item.name}"),
        backgroundColor: CustomColors.appbarColor,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              PricePicker(
                name: "Ürün Fiyatını Güncelle",
                initialMoney: initialMoneyValue,
                initialPenny: initialPennyValue,
                onValueChanged: (int money, int penny) {
                  setState(() {
                    newMoneyValue = money;
                    newPennyValue = penny;
                  });
                },
              ),
              _buildProfitSection(screenSize),
              _buildIngredientSection("Mevcut Çeşitleri Kaldır", widget.item),
              _buildAddIngredientSection(screenSize),
              _buildActionButtons(context, writeData),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfitSection(Size screenSize) {
    return Column(
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
              child: const Text("Değer gir"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isValueEnteredForProfit = false;
                });
              },
              child: const Text("Yüzde gir"),
            ),
          ],
        ),
        SizedBox(
          width: screenSize.width / 3,
          child: Row(
            children: [
              Text(isValueEnteredForProfit ? "Değer:    " : "Yüzde: %"),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: initialProfit != 0
                        ? "$initialProfit"
                        : (isValueEnteredForProfit ? "Değer Giriniz" : "Yüzde giriniz"),
                    errorText: (profit > newMoneyValue)
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
                        profit = ((newMoneyValue * 100 + newPennyValue) / 10000) *
                            (double.tryParse(value) ?? 0.0 / 100);
                        profit = double.parse(profit.toStringAsFixed(2));
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Text("1 adet üründen elde edilen kâr: $profit ₺"),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildIngredientSection(String title, EditableItem editableItem) {
    return Column(
      children: [
        Text(
          title,
          style: CustomTextStyles.blackAndBoldTextStyleL,
        ),
        const SizedBox(height: 16),
        Column(
          children: indList(editableItem),
        ),
      ],
    );
  }

  Widget _buildAddIngredientSection(Size screenSize) {
    return Column(
      children: [
        Text(
          "Çeşit Ekle",
          style: CustomTextStyles.blackAndBoldTextStyleL,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: screenSize.width / 3,
          child: TextFormField(
            controller: itemNameController,
            maxLength: 25,
            decoration: const InputDecoration(
              hintText: 'Çeşit adı girin',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir çeşit adı girin';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              if (value.length <= 25 && value.isNotEmpty) {
                setState(() {
                  widget.item.ingredients.add(value);
                  itemNameController.clear();
                });
              }
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (itemNameController.text.isNotEmpty) {
                widget.item.ingredients.add(itemNameController.text);
                itemNameController.clear();
              }
            });
          },
          child: const Text('Ekle'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, WriteData writeData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          onPressed: () async {
            bool confirmed = await _showConfirmationDialog();
            if (confirmed) {
              await _deleteItem(writeData);
              Navigator.pop(context);
            }
          },
          child: const Text("İtemi Sil", style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("İptal Et"),
        ),
        ElevatedButton(
          onPressed: () async {
            await writeData.setExistingItemInMenu(
              widget.item.name,
              newMoneyValue,
              newPennyValue,
              widget.item.ingredients,
              newProfit: profit,
            );

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Item başarı ile düzenlendi."),
            ));
            Navigator.pop(context);
          },
          child: const Text("Kaydet"),
        ),
      ],
    );
  }

  List<Widget> indList(EditableItem editableItem) {
    List<Widget> indWidgetList = [];
    Size screenSize = MediaQuery.of(context).size;
    if (editableItem.ingredients.isEmpty) {
      indWidgetList.add(const Text("No ingredient"));
    } else {
      for (var i = 0; i < editableItem.ingredients.length; i++) {
        indWidgetList.add(SizedBox(
          width: screenSize.width / 3,
          child: TextButton(
            onPressed: () {
              setState(() {
                editableItem.ingredients.removeAt(i);
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return CustomColors.selectedColor1;
                },
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    editableItem.ingredients[i],
                    style: CustomTextStyles.blackTextStyleS,
                  ),
                  const Icon(Icons.close),
                ],
              ),
            ),
          ),
        ));
      }
    }

    if (indWidgetList.isEmpty) {
      indWidgetList.add(const Text("No ingredient"));
    }

    indWidgetList.add(const SizedBox(height: 10));

    return indWidgetList;
  }

  Future<void> _processMenuData() async {
    ReadMenuData readData = ReadMenuData();
    Map<String, dynamic>? menuData = await readData.getRawData();
    if (menuData != null) {
      List<dynamic> menu = menuData['menu'];
      items = menu.map((item) => EditableItem.fromJson(item)).toList();
      setState(() {});
    }
  }

  Future<void> _deleteItem(WriteData writeData) async {
    await writeData.removeItemFromMenu(widget.item.name);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Item başarı ile silindi."),
    ));
  }

  Future<bool> _showConfirmationDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Emin misiniz?'),
          content: const Text('Bu öğeyi silmek istediğinizden emin misiniz?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sil'),
            ),
          ],
        );
      },
    ) ?? false;
  }
}
