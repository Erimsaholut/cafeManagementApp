import 'package:flutter/material.dart';
import '../constants/styles.dart';

Column CustomMenuButton(
    String buttonText, {
      VoidCallback? onPressedFunction,
      VoidCallback? onLongPressFunction,
      required BuildContext context, // Ekran boyutunu almak için BuildContext ekleniyor
    }) {
  Size screenSize = MediaQuery.of(context).size;

  return Column(
    children: [
      SizedBox(
        width: screenSize.width * 0.3,
        height: screenSize.height * 0.15,
        child: TextButton(
          onPressed: onPressedFunction ?? () {},
          onLongPress: onLongPressFunction,
          style: customButtonStyle,
          child: Text(
            buttonText,
            style: CustomStyles.blackAndBoldTextStyleL,
          ),
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}

final ButtonStyle customButtonStyle = TextButton.styleFrom(
  backgroundColor: Colors.white,
  padding: const EdgeInsets.all(15.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    side: const BorderSide(
      color: Colors.black,
      width: 2.0,
    ),
  ),
);