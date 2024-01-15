import 'package:flutter/material.dart';
import '../../constants/styles.dart';

Widget buildCustomTextField(String labelText, TextEditingController controller) {
  return Column(
    children: [
      Text(
        labelText,
        style: CustomStyles.menuTextStyle,
      ),
      const SizedBox(
        height: 16,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: (String value) {
            // var enteredText = controller.text;
          },
        ),
      ),
    ],
  );
}