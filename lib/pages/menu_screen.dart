import 'package:cafe_management_system_for_camalti_kahvesi/datas/prepareData.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/datas/read_json.dart';
import 'package:flutter/material.dart';
import '../constants/styles.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  List<Widget> foodsWidgetList = [];

  List<Widget> drinksWidgetList = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {});
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
            buildGridView(drinksWidgetList),
            buildItemTypeTextContainer("Yiyecekler"), //yiyecekler
            buildGridView(foodsWidgetList),
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

  void stringToList(ReadJson classType, List<Widget> widgetList) async {
    setState(() {
      List<String> itemNames = classType.getItemNames();
      for (var item in itemNames) {
        widgetList.add(
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              padding: const EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(
                  color: Colors.black,
                  width: 3.0,
                ),
              ),
            ),
            onPressed: () {},
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Text(
                item,
                style: CustomStyles.menuScreenButtonStyle,
              ),
            ),
          ),
        );
      }
    });
  }

  Widget buildGridView(List<Widget> list) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return list[index];
      },
    );
  }
}
