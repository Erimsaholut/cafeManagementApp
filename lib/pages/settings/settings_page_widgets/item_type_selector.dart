import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../../datas/menu_data/read_data_menu.dart';
import '../../../datas/menu_data/write_data_menu.dart';

class CustomItemTypeSelector extends StatefulWidget {
  final String question;
  final String? initialItem;
  final ValueChanged<String> onItemSelected;

  CustomItemTypeSelector({
    super.key,
    required this.question,
    this.initialItem,
    required this.onItemSelected,
  });

  @override
  _CustomItemTypeSelectorState createState() => _CustomItemTypeSelectorState();
}

class _CustomItemTypeSelectorState extends State<CustomItemTypeSelector> {
  List<String> options = [];
  String selectedOption = "";

  @override
  void initState() {
    super.initState();
    _loadOptions();
  }

  Future<void> _loadOptions() async {
    ReadMenuData readMenuData = ReadMenuData();
    List<String> loadedOptions = await readMenuData.getCategories();
    setState(() {
      options = loadedOptions;

      if (widget.initialItem == null) {
        selectedOption = options.isNotEmpty ? options[0] : "";
      } else if (options.contains(widget.initialItem)) {
        selectedOption = widget.initialItem!;
      } else {
        selectedOption = options.isNotEmpty ? options[0] : "";
      }
    });
  }

  Future<void> _addCategory(String newCategory) async {
    WriteMenuData writeMenuData = WriteMenuData();
    await writeMenuData.addCategory(newCategory);
    setState(() {
      options.add(newCategory);
    });
  }

  Future<void> _removeCategory(String category) async {
    WriteMenuData writeMenuData = WriteMenuData();
    await writeMenuData.removeCategory(category);
    setState(() {
      options.remove(category);
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
              onPressed: () async {
                String newCategory = categoryController.text.trim();
                if (newCategory.isNotEmpty && newCategory.length <= 20) {
                  await _addCategory(newCategory);
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
              "Bu kategoriyi silmek istediğinize emin misiniz?\nKategori silinecektir ama bu kategorideki itemlar aynı kalacaktır."),
          actions: <Widget>[
            TextButton(
              child: const Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sil"),
              onPressed: () async {
                await _removeCategory(category);
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
          children: options.map((option) {
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
                      widget.onItemSelected(option);
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
