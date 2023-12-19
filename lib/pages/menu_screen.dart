import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/styles.dart';

Color randomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
} /*sil bunu lazım olmazsa*/

List<Widget> testList = [
  Container(
    color: randomColor(),
    child: Text("çay"),
  ),
  Container(
    color: randomColor(),
    child: Text("Su"),
  ),
  Container(
    color: randomColor(),
    child: Text("Ayran"),
  ),
  Container(
    color: randomColor(),
    child: Text("limonata"),
  ),
  Container(
    color: randomColor(),
    child: Text("Kefir"),
  ),
  Container(
    color: randomColor(),
    child: Text("Nescafe"),
  ),
  Container(
    color: randomColor(),
    child: Text("Türk Kahvesi"),
  ),
  Container(
    color: randomColor(),
    child: Text("Ice Chocolate Mocca"),
  ),
  Container(
    color: randomColor(),
    child: Text("Süryani Şarabı"),
  ),
];
List<Widget> testList2 = [
  Container(color: randomColor(), child: Text("Serpme Kahvaltı")),
  Container(
    color: randomColor(),
    child: Text("Köfte ekmek"),
  ),
  Container(
    color: randomColor(),
    child: Text("Döner"),
  ),
  Container(
    color: randomColor(),
    child: Text("Ekmek arası ekmek"),
  ),
  Container(
    color: randomColor(),
    child: Text("Köfte arası Köfte"),
  ),
  Container(
    color: randomColor(),
    child: Text("Yetimin hakkı"),
  ),
];

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menü"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.blueGrey,
        child: ListView(
          children: [
            Text(
              "İçecekler",
              style: CustomStyles.menuTextStyle,
            ),
            SizedBox(
              height: 16,
            ),
            buildGridView(testList),
            Text(
              "Yiyecekler",
              style: CustomStyles.menuTextStyle,
            ),
            SizedBox(
              height: 16,
            ),
            buildGridView(testList2),
          ],
        ),
      ),
    );
  }

  Widget buildGridView(List<Widget> list) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
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
