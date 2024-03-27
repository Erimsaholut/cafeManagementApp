import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomMultiSelectionButton extends StatefulWidget {
  final String buttonText;
  final List<dynamic>? checkboxTexts;
  final VoidCallback? onPressed;

  const CustomMultiSelectionButton(
      {super.key, required this.buttonText, required this.checkboxTexts, this.onPressed});

  @override
  _CustomMultiSelectionButtonState createState() => _CustomMultiSelectionButtonState();
}

class _CustomMultiSelectionButtonState extends State<CustomMultiSelectionButton> {
  List<bool> checkboxValues = [];

  @override
  void initState() {
    super.initState();
    // Initialize checkbox values based on the length of checkboxTexts
    checkboxValues = List<bool>.filled(widget.checkboxTexts!.length, true);
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.buttonText,
                style: CustomStyles.blackAndBoldTextStyleL,
              ),
              Row(
                children: List.generate(widget.checkboxTexts!.length, (index) {
                  return Row(
                    children: [
                      Text(
                        widget.checkboxTexts?[index].toString() ?? "",
                        style: CustomStyles.blackAndBoldTextStyleM,
                      ),
                      Checkbox(
                        activeColor: Colors.black,
                        visualDensity: const VisualDensity(horizontal: 3.5, vertical: 3.5), // Adjust these values to make the checkbox larger
                        value: checkboxValues[index],
                        onChanged: (value) {
                          setState(() {
                            checkboxValues[index] = value!;
                          });
                        },
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0)
      ],
    );
  }
}
//todo burası düzenlenecek aşağı insin diye
