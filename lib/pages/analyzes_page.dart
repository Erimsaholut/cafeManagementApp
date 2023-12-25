import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/material.dart';

class AnalyzesPage extends StatelessWidget {
  const AnalyzesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ananlyzes",
          style: CustomStyles.menuTextStyle,
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(),
    );
  }
}
