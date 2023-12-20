import 'package:cafe_management_system_for_camalti_kahvesi/utils/styles.dart';
import 'package:flutter/material.dart';

Column CustomMenuButton(String buttonText, {VoidCallback? onPressedFunction}) {
  return Column(
    children: [
      TextButton(
        onPressed: onPressedFunction ?? () {},
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: CustomStyles.menuScreenButtonStyle,
        ),
      ),
      const SizedBox(height: 16,),
    ],
  );
}
