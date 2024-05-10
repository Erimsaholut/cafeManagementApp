import '../../constants/pie_chart_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatefulWidget {
  const CustomPieChart({super.key, required this.itemList});

  final Map<String, int> itemList;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<CustomPieChart> {
  int touchedIndex = -1;
  int colorIndex = 0;
  late Map<String, int> orderedByCount;

  @override
  void initState() {
    super.initState();
    setState(() {
      orderedByCount = orderByCount(widget.itemList);
    });
  }

  Map<String, int> orderByCount(Map<String, int> itemList) {
    List<MapEntry<String, int>> entries = itemList.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    Map<String, int> orderedMap = Map.fromEntries(entries);

    return orderedMap;
  }

  @override
  Widget build(BuildContext context) {
    orderedByCount = orderByCount(widget.itemList);
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: (widget.itemList.isNotEmpty)
                ? PieChart(
                    PieChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      sections: showingSections(
                          orderedByCount),
                    ),
                  )
                : const Text("Belirtilen Tarihe Ait satış verisi bulunamadı",
                    textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildIndicators(orderedByCount),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(Map<String, int> dataMap) {
    if (dataMap.isEmpty) {
      return [];
    }

    List<MapEntry<String, int>> sortedEntries = dataMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double radius = screenHeight / 3.5;
    double fontSize = screenHeight / 35;
    final shadows = [const Shadow(color: Colors.black, blurRadius: 2)];
    int totalEntries = sortedEntries.length;


    int numberOfSections = totalEntries > 5 ? 5 : totalEntries;

    int totalOtherValue = totalEntries > 5
        ? sortedEntries
            .sublist(5)
            .map((entry) => entry.value)
            .fold(0, (a, b) => a + b)
        : 0;

    List<PieChartSectionData> pieChartSections =
        List.generate(numberOfSections, (index) {
      MapEntry<String, int> entry = sortedEntries[index];

      // Renkleri sırayla kullanmak için indeksi mod alarak hesaplayın
      Color selectedColor = colorList[index % colorList.length];

      String title = entry.key;
      if (title.length > 20) {
        title = '${title.substring(0, 20)}...';
      }
      if (title.length > 15) {
        title = '${title.substring(0, 15)}\n${title.substring(15)}';
      }

      return PieChartSectionData(
        color: selectedColor,
        value: entry.value.toDouble(),
        title:
            '${((entry.value / dataMap.values.reduce((a, b) => a + b)) * 100).toStringAsFixed(2)}%\n$title',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );
    });

    if (totalEntries > 5) {

      // "Diğer" kısmı için son renk kullanılacak
      Color selectedColor = colorList[colorList.length - 1];

      pieChartSections.add(
        PieChartSectionData(
          color: selectedColor,
          value: totalOtherValue.toDouble(),
          title:
              '${((totalOtherValue / dataMap.values.reduce((a, b) => a + b)) * 100).toStringAsFixed(2)}%\nDiğer',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.mainTextColor1,
            shadows: shadows,
          ),
        ),
      );
    }

    return pieChartSections;
  }

  List<Widget> buildIndicators(Map<String, int> dataMap) {
    List<Widget> indicators = [];
    int index = 0;

    List<MapEntry<String, int>> topEntries = dataMap.entries
        .toList()
        .sublist(0, dataMap.length > 5 ? 5 : dataMap.length);

    for (var entry in topEntries) {
      Color color = colorList[index % colorList.length];
      index++;
      String text = entry.key;

      if (entry.key.length > 18) {
        text = '${entry.key.substring(0, 18)}\n${entry.key.substring(20)}';
      }
      if (text.length > 36) {
        text = '${text.substring(0, 36)}...';
      }

      indicators.add(
        Indicator(
          color: color,
          text: text,
          isSquare: true,
        ),
      );
    }

    // 5'ten fazla öğe varsa "Diğer" öğesi için son renk kullanılacak
    if (dataMap.length > 5) {
      Color color = colorList[colorList.length - 1]; // Son renk
      indicators.add(
        Indicator(
          color: color,
          text: 'Diğer',
          isSquare: true,
        ),
      );
    }

    return indicators;
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 28,
    this.textColor,
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                color: color,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            )
          ],
        ),
        SizedBox(
          height: (size / 2),
        ),
      ],
    );
  }
}

//todo Eğer toplam veri sayısı 5 ten az ise ne kadar veri var ise onları göstermeli hiç yoksa kocaman bir beyaz boşuk
//todo line ve pieChart için eksik veri konrolü
