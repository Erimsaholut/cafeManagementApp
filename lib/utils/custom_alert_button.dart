import 'package:flutter/material.dart';

class CustomAlertButton extends StatelessWidget {
  final String text1;
  final String text2;
  final String answer1;
  final Function customFunction;

  const CustomAlertButton({
    super.key,
    required this.text1,
    required this.text2,
    this.answer1 = "İptal",
    required this.customFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text1),
      content: Text(text2),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(answer1),
        ),
        TextButton(
          onPressed: () async {
            customFunction();
          },
          child: const Text('Onayla'),
        ),
      ],
    );
  }
}
