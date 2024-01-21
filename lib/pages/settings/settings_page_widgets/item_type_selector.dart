import 'package:flutter/material.dart';
import '../../../constants/styles.dart';

class CustomItemTypeSelector extends StatefulWidget {
  CustomItemTypeSelector({super.key,required this.question,required this.option1,required this.option2,required this.itemType});
  bool isFirstBoxSelected = true;
  String question;
  String option1;
  String option2;
  String itemType;

  @override
  State<CustomItemTypeSelector> createState() => _CustomItemTypeSelectorState();
}

class _CustomItemTypeSelectorState extends State<CustomItemTypeSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.question,
          style: CustomStyles.blackAndBoldTextStyleXl,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.option1, style: CustomStyles.blackAndBoldTextStyleM),
            Checkbox(
              value: widget.isFirstBoxSelected,
              onChanged: (value) {
                setState(() {
                  widget.isFirstBoxSelected = value ?? false;
                  widget.itemType = widget.option1;
                  print(widget.itemType);
                });
              },
            ),
            const SizedBox(width: 64),
            Text(widget.option2, style: CustomStyles.blackAndBoldTextStyleM),
            Checkbox(
              value: !widget.isFirstBoxSelected,
              onChanged: (value) {
                setState(() {
                  widget.isFirstBoxSelected = !(value ?? true);
                  widget.itemType = widget.option2;
                  print(widget.itemType);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}