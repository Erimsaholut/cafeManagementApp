import 'package:cafe_management_system_for_camalti_kahvesi/utils/read_json.dart';
import 'package:flutter/material.dart';
import '../utils/styles.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  ReadJson drinksJson = ReadJson("drinks");

  ReadJson foodsJson = ReadJson("foods");

  List<Widget> foodsWidgetList = [];

  List<Widget> drinksWidgetList = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      stringToList(drinksJson, drinksWidgetList);
      stringToList(foodsJson,foodsWidgetList);
      print("initState Tamamlandı");
      print(foodsWidgetList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menü"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.blueGrey,
        child: ListView(
          children: [
            Text(
              "İçecekler",
              style: CustomStyles.menuTextStyle,
            ),//içecekler
            buildGridView(drinksWidgetList),
            buildSizedBox(),
            Text(
              "Yiyecekler",
              style: CustomStyles.menuTextStyle,
            ),//yiyecekler
            buildSizedBox(),
            buildGridView(foodsWidgetList),

          ],
        ),
      ),
    );
  }

  void stringToList(ReadJson classType,List<Widget> widgetList ) async {
    //itemlerin ismini çekip container olarak listeye sallıyor
    print("aaa");
    setState(() {
      List<String> itemNames = classType.getItemNames();
      for (var item in itemNames) {
        widgetList.add(
          TextButton(
            onPressed: () {  },
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Text(item,style: CustomStyles.menuScreenButtonStyle,),
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
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 18.0,
      ),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return list[index];
      },
    );
  }
}

SizedBox buildSizedBox() {
  return const SizedBox(
    height: 16,
  );
}
