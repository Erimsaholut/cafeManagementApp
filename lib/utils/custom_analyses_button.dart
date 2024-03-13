import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomAnalysesButton extends StatefulWidget {
  const CustomAnalysesButton({super.key,required this.firstButtonText,required this.secondButtonText});

  final String firstButtonText;
  final String secondButtonText;

  @override
  State<CustomAnalysesButton> createState() => _CustomAnalysesButtonState();
}

class _CustomAnalysesButtonState extends State<CustomAnalysesButton> {
  bool firstButtonSelected = true;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              firstButtonSelected = true;
              print("Button1");
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: firstButtonSelected ? Colors.blue : Colors.grey.shade600,
            shape: const RoundedRectangleBorder(),
          ),
          child: Text(widget.firstButtonText,style: CustomStyles.blackTextStyleM,),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              firstButtonSelected = false;
              print("button2");
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: firstButtonSelected ? Colors.grey.shade600 : Colors.blue,
            shape: const RoundedRectangleBorder(),
          ),
          child: Text(widget.secondButtonText,style: CustomStyles.blackTextStyleM,),
        ),
      ],
    );
  }
}
