import 'package:flutter/material.dart';

import '../constants/styles.dart';
Column CustomMenuButton(
    String buttonText, {
      VoidCallback? onPressedFunction,
      VoidCallback? onLongPressFunction,
    }) {
  return Column(
    children: [
      TextButton(

        onPressed: onPressedFunction ?? () {},
        onLongPress: onLongPressFunction,
        style: CustomStyles.customButtonStyle,
        child: Text(
          buttonText,
          style: CustomStyles.blackAndBoldTextStyleL,
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}
