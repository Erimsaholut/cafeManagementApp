import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_colors.dart';
import 'package:flutter/material.dart';
class GrossIncomeGraph extends StatefulWidget {
  const GrossIncomeGraph({super.key});

  @override
  State<GrossIncomeGraph> createState() => _GrossIncomeGraphState();
}

class _GrossIncomeGraphState extends State<GrossIncomeGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(title: const Text("Brüt Gelir Grafiği"),backgroundColor: CustomColors.appbarColor,),
      body: Container(
      ),
    );
  }
}
