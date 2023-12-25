import 'package:flutter/material.dart';

class CustomStyles {
  static TextStyle menuScreenButtonTextStyle = const TextStyle(
    color: Colors.black, // Text color
    fontWeight: FontWeight.bold, // Bold text
    fontSize: 18.0, // Font size
  );
  static TextStyle boldAndBlack = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24);

  static TextStyle menuTextStyle = const TextStyle(
    //todo find usages ile adam gibi isim ve şuna
    color: Colors.black, // Text color
    fontWeight: FontWeight.bold, // Bold text
    fontSize: 24.0, // Font size
  );

  static final ButtonStyle customButtonStyle = TextButton.styleFrom(
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

  static final ButtonStyle customMenuItemButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.white,
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
}
