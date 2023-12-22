import 'package:cafe_management_system_for_camalti_kahvesi/datas/prepareData.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  PrepareData preparedData = PrepareData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menü",
          style: CustomStyles.menuTextStyle,
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.blueGrey,
        child: ListView(
          children: [
            buildItemTypeTextContainer("İçecekler"), //içecekler
            buildItemTypeTextContainer("Yiyecekler"), //yiyecekler
          ],
        ),
      ),
    );
  }

  Container buildItemTypeTextContainer(String text) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Text(
        text,
        style: CustomStyles.menuTextStyle,
      ),
    );
  }
}
