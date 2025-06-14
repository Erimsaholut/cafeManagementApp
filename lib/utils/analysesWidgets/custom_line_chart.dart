import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../constants/custom_utils.dart';
import '../../constants/styles.dart';

class CustomLineChart extends StatefulWidget {
  CustomLineChart({super.key, required this.valueList, this.selectedDate});

  final List<double> valueList;
  final DateTime? selectedDate;

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
  late String month;

  @override
  void initState() {
    super.initState();
    setUtilDatas();
  }

  void setUtilDatas() {
    sortedList = List.from(widget.valueList)..sort();
    minValue = sortedList.first;
    maxValue = sortedList.last;
    itemCount = sortedList.length;
    classCount = calculateClassCount();
    classInterval = calculateClassInterval(classCount);
    classMidpoints =
        calculateClassMidpoints(classCount, classInterval, minValue.round());
    if (widget.selectedDate != null) {
      month = CustomUtils.months[widget.selectedDate!.month - 1];
    } else {
      month = "null";
    }
    print(month);
  }

  int calculateClassCount() {
    int n = widget.valueList.length;
    int classCount = (1.0 + (3.3 * (log(n) / log(10)))).ceil();
    return classCount;
  }

  double calculateClassInterval(int classCount) {
    double minValue = sortedList.first;
    double maxValue = sortedList.last;
    double classInterval = (maxValue - minValue) / classCount;

    return classInterval;
  }

  List<int> calculateClassMidpoints(
      int classCount, double classInterval, int minValue) {
    List<int> classMidpoints = [];

    // Sınıfların orta noktalarını hesapla ve yuvarla
    int midpoint = minValue + (classInterval ~/ 2);
    for (int i = 0; i < classCount + 1; i++) {
      classMidpoints.add(midpoint);
      midpoint += classInterval.toInt();
    }

    return classMidpoints;
  }

  List<FlSpot> flSpotList(List<double> datas) {
    List<FlSpot> spotList = [];
    int index = 0;
    for (var frequency in datas) {
      spotList.add(FlSpot(
          index.toDouble(), frequency)); // Yeni FlSpot nesnesini listeye ekle
      index++; // Sıra numarasını artır
    }
    return spotList;
  }

  @override
  Widget build(BuildContext context) {
    setUtilDatas();
    return Padding(
      padding: const EdgeInsets.only(
        right: 18,
        left: 18,
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
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;

              return LineTooltipItem(
                (itemCount == 12)
                    ? (month != "null")
                        ? "${CustomUtils.months[flSpot.x.toInt()]}\n"
                        : ""
                    : (month != "null")
                        ? "${flSpot.x.toInt() + 1} $month\n"
                        : '',
                const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: flSpot.y.toString(),
                    style: CustomTextStyles.blackAndBoldTextStyleM,
                  ),
                  TextSpan(
                    text: ' ₺ ',
                    style: CustomTextStyles.blackAndBoldTextStyleM,
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: (classInterval > 0) ? classInterval : 1,
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
      /*yazılar*/
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.black),
      ),
      minX: 0,
      maxX: (itemCount - 1.0),
      minY: 0,
      maxY: (classMidpoints.last.roundToDouble()),
      lineBarsData: [
        LineChartBarData(
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
