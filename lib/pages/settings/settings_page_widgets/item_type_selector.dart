import 'package:flutter/material.dart';

class CustomItemTypeSelector extends StatefulWidget {
  final String question;
  final ValueChanged<String> onItemSelected;

  CustomItemTypeSelector({
    super.key,
    required this.question,
    required this.onItemSelected,
  });

  @override
  _CustomItemTypeSelectorState createState() => _CustomItemTypeSelectorState();
}

class _CustomItemTypeSelectorState extends State<CustomItemTypeSelector> {
  List<String> options = ["Yiyecek", "İçecek"]; // Örnek veriler
  String selectedOption = "Yiyecek"; // Varsayılan değer

  @override
  void initState() {
    super.initState();
    widget.onItemSelected(selectedOption); // Varsayılan değeri callback ile ilet
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.question,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: selectedOption == option,
              onSelected: (bool selected) {
                if (selected) {
                  setState(() {
                    selectedOption = option;
                    widget.onItemSelected(option); // Seçilen değeri ilet
                  });
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
