import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_colors.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/custom_utils.dart';
import 'package:cafe_management_system_for_camalti_kahvesi/constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../datas/analyses_data/read_data_analyses.dart';
import '../datas/menu_data/read_data_menu.dart';

class AnalysesAsAText extends StatefulWidget {
  const AnalysesAsAText({super.key});

  @override
  State<AnalysesAsAText> createState() => _AnalysesAsATextState();
}

class _AnalysesAsATextState extends State<AnalysesAsAText> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        title: const Text("Text Analyses"),
        backgroundColor: CustomColors.appbarColor,
      ),
      body: FutureBuilder<List<Widget>>(
        future: getDatas(screenSize),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(), // Veri yüklenirken dönme animasyonu göster
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Error: ${snapshot.error}"), // Hata durumunda hatayı göster
            );
          } else {
            // Veri başarıyla geldiyse snapshot.data içinde bulunur
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return snapshot.data![index];
              },
            );
          }
        },
      ),
    );
  }
}

Future<List<Widget>> getDatas(Size size) async {
  AnalysesReader analysesReader = AnalysesReader();
  ReadMenuData readData = ReadMenuData();
  DateTime now = DateTime.now();
  List<Widget> widgets = [];

  String cafeName = await readData.getCafeName();
  int menuItemCount = await readData.getMenuItemCount();
  double dailyProfit =
      await analysesReader.getDaysTotalProfit(now.day, now.month, now.year);
  double monthlyProfit =
      await analysesReader.getMonthsTotalProfit(now.month, now.year);
  double dailyRevenue =
      await analysesReader.getDaysTotalRevenue(now.day, now.month, now.year);
  double monthlyRevenue =
      await analysesReader.getMonthsTotalRevenue(now.month, now.year);
  Map<String, dynamic>? wholeDay =
      await analysesReader.getDaySet(now.day, now.month, now.year); //bu gün 3
  Map<String, dynamic>? wholeMonth =
      await analysesReader.getMonthSet(now.month, now.year);
  List<String> monthTop3 = getTop3Products(wholeMonth?["products"]!); //bu ay 3
  List<String> dayTop3 = getTop3Products(wholeDay?["products"]!); //bu gün 3
  Map<String, double> dayMostProfit = sortByProfit(wholeDay!); // day most prof
  Map<String, double> monthMostProfit =
      sortByProfit(wholeMonth!); // month most prof
  print(monthMostProfit);
  widgets.add(Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        flex: 14,
        child: customContainer(
          size,
          Colors.lightGreen,
          cafeName,
        ),
      ),
      Expanded(
        flex: 6,
        child: customContainer(
          size,
          Colors.greenAccent,
          "Toplam Ürün Sayısı\n$menuItemCount",
        ),
      ),
    ],
  ));

  widgets.add(Row(
    children: [
      Expanded(
        flex: 4,
        child: customContainer(
          size,
          Colors.redAccent,
          "Bugün",
        ),
      ),
      Expanded(
        flex: 4,
        child: customContainer(
          size,
          Colors.cyanAccent,
          "En çok satılan ürünler",
        ),
      ),
      Expanded(
        flex: 6,
        child: Container(
          height: (size.height / 3),
          color: Colors.cyanAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "#1 ${dayTop3[0]}",
                  style: CustomTextStyles.blackAndBoldTextStyleM,
                ),
                Text(
                  "#2 ${dayTop3[1]}",
                  style: CustomTextStyles.blackAndBoldTextStyleM,
                ),
                Text(
                  "#3 ${dayTop3[2]}",
                  style: CustomTextStyles.blackAndBoldTextStyleM,
                ),
              ],
            ),
          ),
        ),
      ),
      (dayMostProfit.isNotEmpty)?Expanded(
        flex: 4,
        child: customContainer(size, Colors.orangeAccent, "Bu ayın \nen kârlı ürünü\n${dayMostProfit.keys.first}\n${dayMostProfit[dayMostProfit.keys.first]}₺"),
      ):Container(),
      Expanded(
        flex: 3,
        child: customContainer(
          size,
          Colors.yellowAccent,
          "Toplam Gelir\n$dailyRevenue",
        ),
      ),
      Expanded(
        flex: 3,
        child: customContainer(
          size,
          Colors.tealAccent,
          "Toplam Kâr\n$dailyProfit",
        ),
      ),
    ],
  ));

  widgets.add(Row(
    children: [
      Expanded(
        flex: 4,
        child: customContainer(
          size,
          Colors.red,
          "${CustomUtils.months[now.month - 1]} \nAyı boyunca",
        ),
      ),
      Expanded(
        flex: 3,
        child: customContainer(
          size,
          Colors.greenAccent,
          "En çok satılan ürünler",
        ),
      ),
      Expanded(
        flex: 4,
        child: Container(
          height: (size.height / 3),
          color: Colors.greenAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "#1 ${monthTop3[0]}",
                  style: CustomTextStyles.blackAndBoldTextStyleM,
                ),
                Text(
                  "#2 ${monthTop3[1]}",
                  style: CustomTextStyles.blackAndBoldTextStyleM,
                ),
                Text(
                  "#3 ${monthTop3[2]}",
                  style: CustomTextStyles.blackAndBoldTextStyleM,
                ),
              ],
            ),
          ),
        ),
      ),
      (monthMostProfit.isNotEmpty)?Expanded(
        flex: 4,
        child: customContainer(size, Colors.orangeAccent, "Bu ayın \nen kârlı ürünü\n${monthMostProfit.keys.first}\n${monthMostProfit[monthMostProfit.keys.first]}₺"),
      ):Container(),
      Expanded(
        flex: 3,
        child: customContainer(
          size,
          Colors.tealAccent,
          "Toplam Gelir\n$monthlyRevenue",
        ),
      ),
      Expanded(
        flex: 3,
        child: customContainer(
          size,
          Colors.yellowAccent,
          "Toplam Kâr\n$monthlyProfit",
        ),
      ),
    ],
  ));
  (Row(
    children: [
      Expanded(
          flex: 4,
          child: customContainer(
            size,
            Colors.redAccent,
            "${CustomUtils.months[now.month - 1]} \nAyı boyunca",
          )),
      Expanded(
          flex: 4,
          child: Container(
            height: (size.height / 3),
            color: Colors.greenAccent,
            child: const Text(
              "En çok satılan ürünler",
              textAlign: TextAlign.center,
            ),
          )),
      Expanded(
          flex: 6,
          child: Container(
            height: (size.height / 3),
            color: Colors.blueAccent,
            child: Text(
              "$monthTop3",
              textAlign: TextAlign.center,
            ),
          )),
      Expanded(
          flex: 3,
          child: Container(
            height: (size.height / 3),
            color: Colors.yellowAccent,
            child: Text(
              "Toplam Gelir\n$monthlyRevenue",
              textAlign: TextAlign.center,
            ),
          )),
      Expanded(
        flex: 3,
        child: customContainer(
            size, Colors.yellowAccent, "Toplam Kâr\n$monthlyProfit"),
      )
    ],
  ));

  return widgets;
}

List<String> getTop3Products(Map<String, dynamic> products) {
  // Satış miktarına göre ürünleri sıralamak için bir list oluşturma
  var sortedItems = products.entries.toList()
    ..sort((a, b) => b.value['quantity'].compareTo(a.value['quantity']));

  // Top 3 ürünü alarak top3 haritasını oluşturma
  Map<String, int> top3 = {};
  List<String> stringList = [];
  for (var i = 0; i < 3; i++) {
    if (i < sortedItems.length) {
      var item = sortedItems[i];
      top3[item.key] = item.value['quantity'];
      String test = "";
      test += item.key;
      test += ":";
      test += item.value["quantity"].toString();
      test += "\n";
      stringList.add(test);
    } else {
      top3['null'] = 0;
    }
  }

  return stringList;
}

Map<String, double> sortByProfit(Map<String, dynamic> products) {
  Map<String, dynamic> productsMap = products["products"];
  Map<String, double> sortedByProfit = {};
  productsMap.forEach((key, value) {
    if (value is Map && value.containsKey("profit")) {
      sortedByProfit[key] = value["profit"].toDouble();
    }
  });

  sortedByProfit = Map.fromEntries(sortedByProfit.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value)));
  return sortedByProfit;
}

Container customContainer(Size size, Color color, String text) {
  return Container(
    padding: const EdgeInsets.all(10),
    height: (size.height / 3),
    color: color,
    child: Center(
      child: Text(
        text,
        style: CustomTextStyles.blackAndBoldTextStyleM,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
