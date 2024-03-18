import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
    classMidpoints = calculateClassMidpoints(classCount, classInterval,minValue.round());
  }

  int calculateClassCount() {
    // Veri sayısını al
    int n = widget.valueList.length;
    print(n);


    // Sınıf sayısını hesapla
    int classCount = (1.0 + (  3.3 * (log(100)/log(10))  )   ).ceil();
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

  List<int> calculateClassMidpoints(int classCount, double classInterval, int minValue) {
    List<int> classMidpoints = [];

    // Sınıfların orta noktalarını hesapla ve yuvarla
    int midpoint = minValue + (classInterval ~/ 2);
    for (int i = 0; i < classCount; i++) {
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
    datas.forEach((relativeFrequency) {
      spotList.add(FlSpot(index.toDouble(),
          relativeFrequency)); // Yeni FlSpot nesnesini listeye ekle
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
        text = const Text('1', style: style);
        break;
      case 1:
        text = const Text('2', style: style);
        break;
      case 2:
        text = const Text('3', style: style);
        break;
      case 3:
        text = const Text('4', style: style);
        break;
      case 4:
        text = const Text('5', style: style);
        break;
      case 5:
        text = const Text('6', style: style);
        break;
      case 6:
        text = const Text('7', style: style);
        break;
      case 7:
        text = const Text('8', style: style);
        break;
      case 8:
        text = const Text('9', style: style);
        break;
      case 9:
        text = const Text('10', style: style);
        break;
      case 10:
        text = const Text('11', style: style);
        break;
      case 11:
        text = const Text('12', style: style);
        break;
      case 12:
        text = const Text('13', style: style);
        break;
      case 13:
        text = const Text('14', style: style);
        break;
      case 14:
        text = const Text('15', style: style);
        break;
      case 15:
        text = const Text('16', style: style);
        break;
      case 16:
        text = const Text('17', style: style);
        break;
      case 17:
        text = const Text('18', style: style);
        break;
      case 18:
        text = const Text('19', style: style);
        break;
      case 19:
        text = const Text('20', style: style);
        break;
      case 20:
        text = const Text('21', style: style);
        break;
      case 21:
        text = const Text('22', style: style);
        break;
      case 22:
        text = const Text('23', style: style);
        break;
      case 23:
        text = const Text('24', style: style);
        break;
      case 24:
        text = const Text('25', style: style);
        break;
      case 25:
        text = const Text('26', style: style);
        break;
      case 26:
        text = const Text('27', style: style);
        break;
      case 27:
        text = const Text('28', style: style);
        break;
      case 28:
        text = const Text('29', style: style);
        break;
      case 29:
        text = const Text('30', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return text;
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      //todo sınıf sayısına göre çevirmenin bir yolunu bul
      case 60:
        text = '${classMidpoints.first} TL';
        break;
      case 204:
        text = '${((maxValue + minValue) / 2).round()} TL';
        break;
      case 347:
        text = '${classMidpoints.last} TL';
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
        horizontalInterval: classInterval,
        //todo sınıf aralığı gelecek buraya
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
      maxX: 30,
      minY: 0,
      maxY: 400,
      lineBarsData: [
        LineChartBarData(
          //todo değerler girilecek döngü ile
          spots: [...flSpotList(widget.valueList)],
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
