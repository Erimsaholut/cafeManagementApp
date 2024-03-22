import '../../constants/pie_chart_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatefulWidget {
  const CustomPieChart({super.key, required this.itemList});

  final Map<int, Map<String, int>> itemList;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<CustomPieChart> {
  int touchedIndex = -1;
  late Map<String, int> orderedByCount;

  @override
  void initState() {
    super.initState();
    print(widget.itemList);
    orderedByCount = orderByCount(widget.itemList);
  }

  Map<String, int> orderByCount(Map<int, Map<String, int>> itemList) {
    // Boş bir list oluştur
    List<MapEntry<String, int>> entries = [];
    // Her bir item listesini dön
    itemList.forEach((_, innerMap) {
      // İç içe olan map'i dön ve her bir öğe için sayacı artır
      innerMap.forEach((item, count) {
        // MapEntry oluştur ve listeye ekle
        entries.add(MapEntry(item, count));
      });
    });

    entries.sort((a, b) => b.value.compareTo(a.value));

    // Sıralanmış listeyi map'e dönüştür
    Map<String, int> orderedMap = Map.fromEntries(entries);

    print("orderedMap:$orderedMap");

    return orderedMap;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 3,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: showingSections(
                      orderedByCount), /*bölümleri buradan çekiyor*/
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: AppColors.contentColorBlue,
                text: 'First',
                isSquare: true,
              ),
              Indicator(
                color: AppColors.contentColorYellow,
                text: 'Second',
                isSquare: true,
              ),
              Indicator(
                color: AppColors.contentColorPurple,
                text: 'Third',
                isSquare: true,
              ),
              Indicator(
                color: AppColors.contentColorGreen,
                text: 'Fourth',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          /*sağdaki indicatorlar*/
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<Color> colorList = [
    Colors.blue,
    Colors.green,
    Colors.redAccent,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  int colorIndex = 0;

  List<PieChartSectionData> showingSections(Map<String, int> dataMap) {
    List<MapEntry<String, int>> sortedEntries = dataMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    List<MapEntry<String, int>> topEntries = sortedEntries.sublist(
        0, sortedEntries.length > 5 ? 5 : sortedEntries.length);

    int totalOtherValue = sortedEntries
        .sublist(5)
        .map((entry) => entry.value)
        .fold(0, (previousValue, element) => previousValue + element);

    List<PieChartSectionData> pieChartSections = topEntries.map((entry) {
      Size screenSize = MediaQuery.of(context).size;
      double screenHeight = screenSize.height;
      double y = screenHeight/3;

      double fontSize = screenHeight/30;
      double radius = y;
      final shadows = [const Shadow(color: Colors.black, blurRadius: 2)];

      Color selectedColor = colorList[colorIndex];
      colorIndex = (colorIndex + 1) % colorList.length;

      return PieChartSectionData(
        color: selectedColor,
        value: entry.value.toDouble(),
        title:
            '${((entry.value / dataMap.values.reduce((a, b) => a + b)) * 100).toStringAsFixed(2)}%\n${entry.key}',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );
    }).toList();

    if (sortedEntries.length > 5) {
      Size screenSize = MediaQuery.of(context).size;
      double screenHeight = screenSize.height;
      double y = screenHeight/3;

      double fontSize = screenHeight/30;
      final shadows = [const Shadow(color: Colors.black, blurRadius: 2)];

      Color selectedColor = colorList[colorIndex];
      colorIndex = (colorIndex + 1) % colorList.length;

      pieChartSections.add(
        PieChartSectionData(
          color: selectedColor,
          value: totalOtherValue.toDouble(),
          title:
              '${((totalOtherValue / dataMap.values.reduce((a, b) => a + b)) * 100).toStringAsFixed(2)}%\nDiğer',
          radius: y,
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
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 32,
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

//todo ekrana göre ayarlama işlemi kaldı
//todo Eğer toplam veri sayısı 5 ten az ise ne kadar veri var ise onları göstermeli hiç yoksa kocaman bir beyaz boşuk
