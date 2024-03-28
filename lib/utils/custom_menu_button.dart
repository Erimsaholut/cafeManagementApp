import 'package:flutter/material.dart';
import '../constants/styles.dart';
import 'custom_sized_box.dart';

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
            style: CustomTextStyles.blackAndBoldTextStyleL,
          ),
        ),
      ),
      CustomSizedBox(),
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