import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysesPage extends StatefulWidget {
  const AnalysesPage({super.key});

  @override
  State<AnalysesPage> createState() => _AnalysesPageState();
}

class _AnalysesPageState extends State<AnalysesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analyses"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
          color: Colors.orange.shade100,
          child: Row(
            children: [
              Expanded(child: Container(
                color: Colors.amberAccent,
                child: PieChart(
                  PieChartData(sections: [
                    PieChartSectionData(value: 10, radius: 75),
                    PieChartSectionData(value: 25, radius: 75),
                    PieChartSectionData(value: 10, radius: 75),
                    PieChartSectionData(value: 10, radius: 75),
                  ]),
                  swapAnimationDuration:
                  Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear,
                ),
              )),
              Expanded(
                  child: Container(
                color: Colors.orange,
                child: LineChart(
                  LineChartData(
                    minX: 100,
                    minY: 100,
                    lineBarsData: [
                      LineChartBarData(
                        color: Colors.blueAccent,
                        barWidth: 6,
                        // isCurved: true,
                      ),
                      LineChartBarData(
                        color: Colors.blueAccent,
                        barWidth: 6,
                        // isCurved: true,
                      ),
                      LineChartBarData(
                        color: Colors.blueAccent,
                        barWidth: 6,
                        // isCurved: true,
                      ),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(),
                      rightTitles: AxisTitles(),
                    ),
                  ),
                ),
              ))
            ],
          )),
    );
  }
}
