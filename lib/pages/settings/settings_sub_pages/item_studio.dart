import 'package:flutter/material.dart';
import 'package:adisso/pages/settings/settings_page_widgets/item_type_selector.dart';
import '../../../datas/menu_data/write_data_menu.dart';
import '../../../datas/menu_data/read_data_menu.dart';
import '../../../constants/custom_colors.dart';
import '../../../utils/price_picker.dart';
import '../../../constants/styles.dart';
import 'edit_items_page.dart';

class ItemStudio extends StatefulWidget {
  const ItemStudio({super.key, required this.item, required this.processMenu});

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
  final TextEditingController categoryController = TextEditingController();
  List<String> categories = [];
  late CustomItemTypeSelector customItemTypeSelector;
  late String selectedItemType;

  @override
  void initState() {
    super.initState();
    selectedItemType = widget.item.type;
    initialMoneyValue = widget.item.price.floor();
    initialPennyValue =
        ((widget.item.price - widget.item.price.floor()) * 100).round();
    initialProfit = widget.item.profit;
    newMoneyValue = initialMoneyValue;
    newPennyValue = initialPennyValue;
    profit = initialProfit;

    // Initialize CustomItemTypeSelector
    customItemTypeSelector = CustomItemTypeSelector(
      question: "Ürünün kategorisini düzenle",
      initialItem: widget.item.type,
      onItemSelected: (String value) {
        setState(() {
          selectedItemType = value;
        });
      },
    );

    _processMenuData();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    categoryController.dispose();
    super.dispose();
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

  Future<void> _deleteItem(WriteMenuData writeData) async {
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
          content:
          const Text('Bu öğeyi silmek istediğinizden emin misiniz?'),
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
    ) ??
        false;
  }

  void _addCategory(String newCategory) {
    setState(() {
      categories.add(newCategory);
    });
  }

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Yeni Kategori Ekle"),
          content: TextField(
            controller: categoryController,
            maxLength: 20,
            decoration: const InputDecoration(
              hintText: "Kategori ismi",
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("İptal"),
            ),
            TextButton(
              onPressed: () {
                String newCategory = categoryController.text.trim();
                if (newCategory.isNotEmpty && newCategory.length <= 20) {
                  _addCategory(newCategory);
                  Navigator.of(context).pop();
                  categoryController.clear();
                }
              },
              child: const Text("Ekle"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final WriteMenuData writeData = WriteMenuData();
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
              customItemTypeSelector,
              const SizedBox(height: 20,),
              _buildIngredientSection(
                  "Mevcut Seçenekleri Kaldır", widget.item),
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
                        : (isValueEnteredForProfit
                        ? "Değer Giriniz"
                        : "Yüzde giriniz"),
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
                        profit =
                            ((newMoneyValue * 100 + newPennyValue) / 10000) *
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
          style: CustomTextStyles.blackAndBoldTextStyleXl,
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
          "Seçenek Ekle",
          style: CustomTextStyles.blackAndBoldTextStyleXl,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: screenSize.width / 3,
          child: TextFormField(
            controller: itemNameController,
            maxLength: 25,
            decoration: const InputDecoration(
              hintText: 'Seçenek adı girin',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir seçenek adı girin';
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

  Widget _buildActionButtons(BuildContext context, WriteMenuData writeData) {
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
              selectedItemType,
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
      indWidgetList.add(const Text("Mevcut seçenek yok"));
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
}
