import 'package:flutter/material.dart';

import '../../../constants/styles.dart';


Widget buildCustomTextField(String labelText, TextEditingController controller, BuildContext context) {
  FocusNode focusNode = FocusNode();

  return Column(
    children: [
      Text(
        labelText,
        style: CustomStyles.blackAndBoldTextStyleXl,
      ),
      const SizedBox(
        height: 16,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: TextField(
          maxLength: 50,
          controller: controller,
          focusNode: focusNode, // FocusNode'u TextField'a atanır
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: (String value) {
            // TextField'a bir şey yazıldığında
          },
        ),
      ),
      // Column'a tıklandığında focusu kaybetmek için GestureDetector kullanılır
      GestureDetector(
        onTap: () {
          // Focus'u kaybet
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: 0,
          width: 0,
        ),
      ),
    ],
  );
}
