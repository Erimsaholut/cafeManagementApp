import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomSingleSelectionButton extends StatefulWidget {
  final String buttonText;
  final List<String> checkboxTexts;
  final ValueChanged<String>? onItemSelected;
  final VoidCallback? onPressed;

  const CustomSingleSelectionButton({
    Key? key,
    required this.buttonText,
    required this.checkboxTexts,
    this.onItemSelected,
    this.onPressed,
  }) : super(key: key);

  @override
  _CustomSingleSelectionButtonState createState() =>
      _CustomSingleSelectionButtonState();
}

class _CustomSingleSelectionButtonState
    extends State<CustomSingleSelectionButton> {
  late String selectedCheckbox;

  @override
  void initState() {
    super.initState();
    selectedCheckbox = widget.checkboxTexts.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 96),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.buttonText,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Flexible(
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ...widget.checkboxTexts.map((checkboxText) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              checkboxText,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Radio(
                              value: checkboxText,
                              groupValue: selectedCheckbox,
                              onChanged: (value) {
                                setState(() {
                                  selectedCheckbox = value as String;
                                  widget.onItemSelected?.call(selectedCheckbox);
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
