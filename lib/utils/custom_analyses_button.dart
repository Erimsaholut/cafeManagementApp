import 'package:flutter/material.dart';

class CustomAnalysesButton extends StatefulWidget {
  const CustomAnalysesButton({
    Key? key,
    required this.firstButtonText,
    required this.secondButtonText,
    this.thirdButtonText,
  }) : super(key: key);

  final String firstButtonText;
  final String secondButtonText;
  final String? thirdButtonText;

  @override
  State<CustomAnalysesButton> createState() => _CustomAnalysesButtonState();
}

class _CustomAnalysesButtonState extends State<CustomAnalysesButton> {
  bool firstButtonSelected = true;
  bool secondButtonSelected = false;
  bool thirdButtonSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              firstButtonSelected = true;
              secondButtonSelected = false;
              thirdButtonSelected= false;
              print("Button1");
            });
          },
          style: TextButton.styleFrom(
            backgroundColor:
            (firstButtonSelected) ? Colors.blue : Colors.grey.shade600,
            shape: const RoundedRectangleBorder(),
          ),
          child: Text(widget.firstButtonText),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              firstButtonSelected = false;
              secondButtonSelected = true;
              thirdButtonSelected= false;
              print("button2");
            });
          },
          style: TextButton.styleFrom(
            backgroundColor:
            secondButtonSelected ? Colors.blue: Colors.grey.shade600,
            shape: const RoundedRectangleBorder(),
          ),
          child: Text(widget.secondButtonText),
        ),
        if (widget.thirdButtonText != null)
          TextButton(
            onPressed: () {
              setState(() {
                firstButtonSelected = false;
                secondButtonSelected = false;
                thirdButtonSelected= true;
                print("button3");
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: thirdButtonSelected ? Colors.blue : Colors.grey.shade600,
              shape: const RoundedRectangleBorder(),
            ),
            child: Text(widget.thirdButtonText!),
          ),
      ],
    );
  }
}
