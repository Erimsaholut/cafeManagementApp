import 'package:adisso/datas/menu_data/read_data_menu.dart';
import 'package:adisso/datas/menu_data/write_data_menu.dart';
import 'package:flutter/material.dart';
import '../../../constants/styles.dart';

class CustomItemTypeSelector extends StatefulWidget {
  CustomItemTypeSelector({
    super.key,
    required this.question,
    required this.itemType,
  });

  String question;
  String itemType;
  List<String> options = [];

  @override
  State<CustomItemTypeSelector> createState() => _CustomItemTypeSelectorState();
}

class _CustomItemTypeSelectorState extends State<CustomItemTypeSelector> {
  String selectedOption = "";

  @override
  void initState() {
    super.initState();
    _loadOptions();
  }

  void _loadOptions() async {
    ReadMenuData readMenuData = ReadMenuData();
    List<String> options = await readMenuData.getCategories();
    setState(() {
      widget.options = options;
      if (options.isNotEmpty) {
        selectedOption =
            options[0]; // İlk seçenek varsayılan olarak seçili olabilir
        widget.itemType = options[0];
      }
    });
  }

  Future<void> _addCategory(String newCategory) async {
    WriteMenuData writeMenuData = WriteMenuData();
    setState(() {
      writeMenuData.addCategory(newCategory);
      widget.options.add(newCategory);
    });
  }

  Future<void> _removeCategory(String category) async {
    WriteMenuData writeMenuData = WriteMenuData();
    setState(() {
      writeMenuData.removeCategory(category);
      widget.options.remove(category);
    });
  }

  void _showAddCategoryDialog() {
    TextEditingController categoryController = TextEditingController();
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
              child: const Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Ekle"),
              onPressed: () {
                String newCategory = categoryController.text.trim();
                if (newCategory.isNotEmpty && newCategory.length <= 20) {
                  _addCategory(newCategory);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Emin misiniz?"),
          content: const Text(
              "Bu kategoriyi silmek istediğinize emin misiniz?\nKategori silinecektir ama bu kategorideki itemler aynı kalacaktır."),
          actions: <Widget>[
            TextButton(
              child: const Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sil"),
              onPressed: () {
                _removeCategory(category);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.question,
          style: CustomTextStyles.blackAndBoldTextStyleXl,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          children: widget.options.map((option) {
            return GestureDetector(
              onLongPress: () {
                _showDeleteConfirmationDialog(option);
              },
              child: ChoiceChip(
                label: Text(
                  option,
                  style: CustomTextStyles.blackAndBoldTextStyleM,
                ),
                selected: selectedOption == option,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedOption = option;
                      widget.itemType = option;
                      print(widget.itemType);
                    }
                  });
                },
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _showAddCategoryDialog,
          child: const Text("Kategori Ekle"),
        ),
      ],
    );
  }
}
