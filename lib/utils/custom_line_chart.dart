import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CustomLineChart extends StatefulWidget {
  CustomLineChart({super.key, required this.valueList});

  List<double> valueList;

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  List<Color> gradientColors = [
    Colors.green,
    Colors.deepPurple,
    Colors.red,
  ];

  late List<double> sortedList;
  late double minValue;
  late double maxValue;
  late int itemCount;
  late int classCount;
  late double classInterval;
  late List<int> classMidpoints;

  @override
  void initState() {
    super.initState();
    sortedList = List.from(widget.valueList)..sort();
    minValue = sortedList.first;
    maxValue = sortedList.last;
    itemCount = sortedList.length;
    classCount = calculateClassCount();
    classInterval = calculateClassInterval(classCount);
    classMidpoints =
        calculateClassMidpoints(classCount, classInterval, minValue.round());
  }

  int calculateClassCount() {
    // Veri sayısını al
    int n = widget.valueList.length;
    print("n:$n");

    // Sınıf sayısını hesapla
    int classCount = (1.0 + (3.3 * (log(n) / log(10)))).ceil();

    print("classCount:$classCount");
    return classCount;
  }

  double calculateClassInterval(int classCount) {
    double minValue = sortedList.first;
    double maxValue = sortedList.last;
    double classInterval = (maxValue - minValue) / classCount;
    print("classInterval:$classInterval");

    return classInterval;
  }

  List<int> calculateClassMidpoints(
      int classCount, double classInterval, int minValue) {
    List<int> classMidpoints = [];

    // Sınıfların orta noktalarını hesapla ve yuvarla
    int midpoint = minValue + (classInterval ~/ 2);
    for (int i = 0; i < classCount+1; i++) {
      classMidpoints.add(midpoint);
      midpoint += classInterval.toInt();
    }
    print("classMidpoints:$classMidpoints");

    return classMidpoints;
  }

  List<FlSpot> flSpotList(List<double> datas) {
    List<FlSpot> spotList = [];
    int index = 0; // Sıra numarası için bir sayaç

    // Verilen göreli sıklık verilerini döngüye al
    datas.forEach((frequency) {
      spotList.add(FlSpot(
          index.toDouble(), frequency)); // Yeni FlSpot nesnesini listeye ekle
      index++; // Sıra numarasını artır
    });

    return spotList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 18,
        left: 12,
        top: 24,
        bottom: 12,
      ),
      child: LineChart(
        mainData(),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;

    if (value.toInt() >= 0 && value.toInt() < itemCount) {
      text = Text((value.toInt() + 1).toString(), style: style);
    } else {
      text = const Text('', style: style);
    }

    return text;
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    for (int midpoint in classMidpoints) {
      if (value == midpoint) {
        // Metni oluştur
        text = '${(midpoint / 10).round() * 10} ';
        return Text(text, style: style, textAlign: TextAlign.right);
      }
    }

    // Eğer value classMidpoints listesinde değilse, boş bir Container döndür
    return Container();
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: classInterval,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.blueAccent,
            strokeWidth: 1 ,
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
      ), /*yazılar*/
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: (itemCount - 1.0),
      minY: 0,
      maxY: (classMidpoints.last.roundToDouble()),
      lineBarsData: [
        LineChartBarData(
          //todo değerler girilecek döngü ile
          spots: [...flSpotList(widget.valueList)],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.5))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
