import 'package:flutter/material.dart';

import '../constants/custom_colors.dart';
class NetIncomeGraph extends StatefulWidget {
  const NetIncomeGraph({super.key});

  @override
  State<NetIncomeGraph> createState() => _NetIncomeGraphState();
}

class _NetIncomeGraphState extends State<NetIncomeGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(title: const Text("Net Kâr Grafiği"),backgroundColor: CustomColors.appbarColor,),
      body: Container(
      ),
    );
  }
}
