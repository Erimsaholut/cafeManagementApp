import 'package:flutter/material.dart';

class MyCustomButton extends StatefulWidget {
  final String buttonText;
  final List<dynamic>? checkboxTexts;
  final VoidCallback? onPressed;

  MyCustomButton({required this.buttonText, required this.checkboxTexts, this.onPressed});

  @override
  _MyCustomButtonState createState() => _MyCustomButtonState();
}

class _MyCustomButtonState extends State<MyCustomButton> {
  List<bool> checkboxValues = [];

  @override
  void initState() {
    super.initState();
    // Initialize checkbox values based on the length of checkboxTexts
    checkboxValues = List<bool>.filled(widget.checkboxTexts!.length, true);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.buttonText),
          Row(
            children: List.generate(widget.checkboxTexts!.length, (index) {
              return Row(
                children: [
                  Text(widget.checkboxTexts?[index].toString() ?? ""), // Cast to String
                  Checkbox(
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
    );
  }
}
