import 'package:flutter/material.dart';

class CustomSingleSelectionButton extends StatefulWidget {
  final String buttonText;
  final List<String> checkboxTexts;
  final ValueChanged<String>? onItemSelected;
  final VoidCallback? onPressed;

  CustomSingleSelectionButton({
    required this.buttonText,
    required this.checkboxTexts,
    this.onItemSelected,
    this.onPressed,
  });

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
    // Başlangıçta ilk checkbox'u seçili olarak işaretle
    selectedCheckbox = widget.checkboxTexts.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 96),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.buttonText,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  for (String checkboxText in widget.checkboxTexts)
                    Row(
                      children: [
                        Text(
                          checkboxText,
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16,),
      ],
    );
  }
}
