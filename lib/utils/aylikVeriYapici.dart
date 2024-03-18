import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomMonthlyChart extends StatefulWidget {
  CustomMonthlyChart({super.key, required this.valueList});

  List<double> valueList;

  @override
  State<CustomMonthlyChart> createState() => _CustomMonthlyChartState();
}

class _CustomMonthlyChartState extends State<CustomMonthlyChart> {
  List<Color> gradientColors = [
    Colors.green,
    Colors.deepPurple,
  ];

  bool showAvg = false;
  late List<double> sortedList;
  late double minValue;
  late double maxValue;
  late int itemCount; // Item sayısı
  late Map<double, double> relativeFrequencies; // Göreli sıklık değerleri

  @override
  void initState() {
    super.initState();
    // Değer listesini sırala
    sortedList = List.from(widget.valueList)..sort();
    minValue = sortedList.first;
    maxValue = sortedList.last;
    itemCount = sortedList.length; // Item sayısını atama
    calculateRelativeFrequencies();
    print(relativeFrequencies);
  }

  // Her bir öğenin göreli sıklığını hesaplayan metod
  void calculateRelativeFrequencies() {
    relativeFrequencies = {};
    double totalSum =
        widget.valueList.reduce((a, b) => a + b); // Toplam değeri hesapla

    widget.valueList.forEach((item) {
      relativeFrequencies[item] =
          item * 10 / totalSum; // Göreli sıklığı hesapla
    });
  }

  List<FlSpot> flSpotList(Map<double, double> datas) {
    List<FlSpot> spotList = [];
    int index = 0; // Sıra numarası için bir sayaç

    // Verilen göreli sıklık verilerini döngüye al
    datas.values.forEach((relativeFrequency) {
      spotList.add(FlSpot(index.toDouble(), relativeFrequency)); // Yeni FlSpot nesnesini listeye ekle
      index++; // Sıra numarasını artır
    });

    return spotList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3.00,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('1.Hafta', style: style);
        break;
      case 1:
        text = const Text('2.Hafta', style: style);
      case 2:
        text = const Text('3.Hafta', style: style);
        break;
      case 3:
        text = const Text('4.Hafta', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      //todo max ve min değerleri yazdırılacak buraya
      case 1:
        text = '${minValue.floor()} Tl';
        break;
      case 2:
        text = '${((maxValue + minValue) / 2).round()} Tl';
        break;
      case 3:
        text = '${maxValue.ceil()} Tl';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.blueAccent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.red,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets, /*alttaki yazılar*/
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            /*soldaki yazılar*/
            reservedSize: 62,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 3,
      minY: 0,
      maxY: 4,
      lineBarsData: [
        LineChartBarData(
          //todo değerler girilecek döngü ile
          spots: [...flSpotList(relativeFrequencies)],
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
