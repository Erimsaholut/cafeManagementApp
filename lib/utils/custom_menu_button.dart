import 'package:flutter/material.dart';
import '../constants/styles.dart';

Column customMenuButton(
    String buttonText, {
      VoidCallback? onPressedFunction,
      VoidCallback? onLongPressFunction,
      required BuildContext context,
      bool isEnabled = true,
    }) {
  Size screenSize = MediaQuery.of(context).size;

  return Column(
    children: [
      SizedBox(
        width: screenSize.width * 0.3,
        height: screenSize.height * 0.15,
        child: TextButton(
          onPressed: isEnabled ? onPressedFunction ?? () {} : null,
          onLongPress: isEnabled ? onLongPressFunction : null,
          style: isEnabled ? customButtonStyle : customButtonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade400),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Colors.grey.shade700, width: 2.0),
            ),
          ),
          child: Text(
            buttonText,
            style: CustomTextStyles.blackAndBoldTextStyleL,
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
