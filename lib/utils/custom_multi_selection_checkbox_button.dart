
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/styles.dart';

class CustomMultiSelectionButton extends StatefulWidget {
  final String buttonText;
  final List<dynamic>? checkboxTexts;
  final VoidCallback? onPressed;

  const CustomMultiSelectionButton({
    super.key,
    required this.buttonText,
    required this.checkboxTexts,
    this.onPressed,
  });

  @override
  _CustomMultiSelectionButtonState createState() =>
      _CustomMultiSelectionButtonState();
}

class _CustomMultiSelectionButtonState
    extends State<CustomMultiSelectionButton> {
  List<bool> checkboxValues = [];

  @override
  void initState() {
    super.initState();
    checkboxValues = List<bool>.filled(widget.checkboxTexts!.length, true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: widget.onPressed,
          style: CustomButtonStyles.buttonWitchCheckBoxStyle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.buttonText,
                  style: CustomTextStyles.blackAndBoldTextStyleL,
                ),
                Flexible(
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: List.generate(
                      widget.checkboxTexts!.length,
                      (index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.checkboxTexts?[index].toString() ?? "",
                              style: CustomTextStyles.blackAndBoldTextStyleM,
                            ),
                            Checkbox(
                              activeColor: Colors.black,
                              visualDensity: const VisualDensity(
                                  horizontal: 3.5, vertical: 3.5),
                              // Adjust these values to make the checkbox larger
                              value: checkboxValues[index],
                              onChanged: (value) {
                                setState(() {
                                  checkboxValues[index] = value!;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0)
      ],
    );
  }
}
