import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/read_data_menu.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/menu_data/write_data_menu.dart';
import '../../../utils/price_picker.dart';
import '../../../constants/styles.dart';
import 'package:flutter/material.dart';
import 'EditItems2.dart';

class ItemStudio extends StatefulWidget {
  const ItemStudio({Key? key, required this.item}) : super(key: key);

  final EditableItem item;

  @override
  State<ItemStudio> createState() => _ItemStudioState();
}

class _ItemStudioState extends State<ItemStudio> {
  List<EditableItem> items = [];
  late int initialMoneyValue;
  late int initialPennyValue;
  late int newMoneyValue;
  late int newPennyValue;

  @override
  void initState() {
    super.initState();
    initialMoneyValue = widget.item.price.floor();
    initialPennyValue =
        ((widget.item.price - widget.item.price.floor()) * 100).round();
    newMoneyValue = initialMoneyValue;
    newPennyValue = initialPennyValue;
    _processMenuData();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController itemNameController = TextEditingController();
    WriteData writeData = WriteData();
    Size screenSize = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Colors.lime.shade300,
      appBar: AppBar(
        title: Text("Edit  ${widget.item.name}"),
        backgroundColor: Colors.orangeAccent,
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
              Text(
                "Mevcut Çeşitleri Kaldır",
                style: CustomStyles.blackAndBoldTextStyleL,
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  ...(indList(widget.item)),
                ],
              ),
              Text(
                "Çeşit Ekle",
                style: CustomStyles.blackAndBoldTextStyleL,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: (screenSize.width / 3),
                child: TextFormField(
                  controller: itemNameController,
                  maxLength: 25, // Maksimum karakter sayısı
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
                    if (itemNameController.text.length <= 25 && itemNameController.text.isNotEmpty) {
                      setState(() {
                        widget.item.ingredients.add(itemNameController.text);
                        itemNameController.clear();
                      });
                    }
                  },
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if(itemNameController.text.isNotEmpty){
                      widget.item.ingredients.add(itemNameController.text);
                      itemNameController.clear();
                    }

                  });
                },
                child: const Text('Ekle'),
              ),

              const SizedBox(height: 16,),
              /*çeşit ekle*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("İptal Et")),
                  ElevatedButton(
                      onPressed: () {

                        print("gelmeden önce");
                        print("$newMoneyValue tl $newPennyValue krş");
                        writeData.setExistingItemInMenu(
                            widget.item.name,
                            newMoneyValue,
                            newPennyValue,
                            widget.item.ingredients);
                        //todo değiştirmemiş
                      },
                      child: const Text("Kaydet")),
                ],
              )
            ],
          ),
        ],
      ),
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
              editableItem.ingredients.removeAt(i);
              setState(() {});
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Colors.red.shade300;
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
                    style: CustomStyles.blackTextStyleS,
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

    indWidgetList.add(const SizedBox(
      height: 10,
    ));

    return indWidgetList;
  }

  Future<void> _processMenuData() async {
    ReadData readData = ReadData();
    Map<String, dynamic>? rawMenu = await readData.getRawData();

    setState(() {
      items.clear();
      for (var itemData in rawMenu?["menu"]) {
        EditableItem newItem = EditableItem(
          id: itemData["id"],
          name: itemData["name"],
          price: itemData["price"],
          ingredients: List<String>.from(itemData["ingredients"]),
        );
        items.add(newItem);
      }
    });
  }
}
//todo fileda girilen karaketerleri sınırlamayı her yere ekle
//todo item silinecektir emin misiniz
//ya her şey güzel ama tekrar refreshlenmiyor ind değiştirildiğinde.