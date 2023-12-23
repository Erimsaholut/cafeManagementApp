import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/material.dart';

Column CustomMenuButton(String buttonText, {VoidCallback? onPressedFunction}) {
  return Column(
    children: [
      TextButton(
        onPressed: onPressedFunction ?? () {},
        style: CustomStyles.customButtonStyle,
        child: Text(
          buttonText,
          style: CustomStyles.menuScreenButtonTextStyle,
        ),
      ),
      const SizedBox(height: 16,),
    ],
  );
}
