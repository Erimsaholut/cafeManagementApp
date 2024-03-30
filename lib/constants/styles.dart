import 'package:flutter/material.dart';

class CustomTextStyles {

  static TextStyle blackAndBoldTextStyleM = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15);

  static TextStyle blackTextStyleM = const TextStyle(
      color: Colors.black, fontSize: 15);



  static TextStyle blackAndBoldTextStyleL = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  static TextStyle blackTextStyleS = const TextStyle(
    color: Colors.black,
    fontSize: 14.0,
  );

  static TextStyle blackAndBoldTextStyleXl = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24);

}
class CustomButtonStyles {

  static final ButtonStyle customMenuItemButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
    ),
  );

  static final ButtonStyle transparentButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.transparent,
    padding: const EdgeInsets.all(16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  static final ButtonStyle buttonWitchCheckBoxStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 96),
    side:const BorderSide(width: 2,color: Colors.black),
  );


}
